class AttachmentsController < ResourceController
  respond_to :json

  layout Proc.new {|c| c.parent? ? c.choose_parent_layout : 'application' }
  #custom_actions resource: [:download]

  belongs_to :tcp, :project, optional: true, polymorphic: true

  has_scope :title_or_desc
  has_scope :attachment_category_id_equals, as: :category_id
  has_scope :attachment_job_type_id_equals, as: :job_type_id
  has_scope :file_content_type_equals, as: :content_type
  has_scope :start_date_after, as: :start_date
  has_scope :finish_date_before, as: :finish_date
  has_scope :order, default: 'created_at DESC'
  has_scope :page, default: 1
  has_scope :per, default: 5

  def index
    set_collection_ivar(apply_scopes(parent.related_attachments).decorate) if parent?
    index! do
      @existed_content_types = Attachment.get_content_types
      @existed_job_types = AttachmentJobType.all
      @existed_categories = AttachmentCategory.all
    end
  end

  def create
    create! do |format|
      if parent?
        att = Attachmentization.new
        att.attachmentable = parent
        att.through_attachmentable = parent
        att.attachment = @attachment
        att.save!
      end
      format.html
    end
  end

  def content_types
    types = Attachment.select(:file_content_type).uniq
    result = types.map(&:file_content_type)
    render json: result
  end

  def form
    @attachment = Attachment.new
    render partial: 'form'
  end

  def download
    @attachment = Attachment.find(params[:id])
    send_file @attachment.file.path
  end

end
