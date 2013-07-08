module Projectable
  extend ActiveSupport::Concern

  STATES = %w(active closed completed)
  included do
    acts_as_commentable
    attr_accessible :description, :title, :attachment_ids, :company_id, :client_id,
                    :staff_attributes, :planned_start_date, :planned_complete_date

    has_state :state

    belongs_to :company
    belongs_to :client, class_name: User.name
    has_one  :project, foreign_key: 'id'
    has_many :staff, as: :staffable, class_name: StaffMember.name
    has_many :users, through: :staff
    has_many :attachmentizations, as: :attachmentable
    has_many :attachments, through: :attachmentizations
    has_many :tasks, as: :taskable
    has_many :questions, as: :questionable
    has_many :tasks_attachments, class_name: Attachment.name, through: :tasks, source: :attachments
    has_many :tasks_comment_threads, class_name: Comment.name, through: :tasks, source: :comment_threads
    has_many :questions_comment_threads, class_name: Comment.name, through: :questions, source: :comment_threads
    has_many :tasks_comment_threads_attachments, class_name: Attachment.name,
             through: :tasks_comment_threads, source: :attachments
    has_many :questions_attachments, class_name: Attachment.name, through: :questions, source: :attachments
    has_many :questions_comment_threads_attachments, class_name: Attachment.name,
             through: :questions_comment_threads, source: :attachments
    has_many :comment_threads_attachments, class_name: Attachment.name,
             through: :comment_threads, source: :attachments

    accepts_nested_attributes_for :staff, allow_destroy: true

    delegate :users, to: :company, prefix: true, allow_nil: true

    validates_presence_of :title, :description, :company_id, :client_id, :staff

    before_save ThroughAttachmentableCallbacks.new

    state_machine initial: :active do
      event :activate do
        transition any - :active => :active
      end

      event :close do
        transition any - :closed => :closed
      end

      event :complete do
        transition any - :completed => :completed
      end
    end
  end

  def completeness_percentage
    if planned_complete_date.nil?
      100.0
    else
      sum_days = planned_complete_date - planned_start_date
      days_from_start = Date.today - planned_start_date

      days_from_start.to_f / sum_days.to_f * 100
    end
  end

  def to_s
    title
  end
end