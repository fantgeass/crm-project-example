class CommentsController < ResourceController
  respond_to :json
  layout :choose_parent_layout, only: [:index]
  defaults collection_name: 'comment_threads'

  belongs_to :tcp, :project, polymorphic: true do
    belongs_to :task, :question, polymorphic: true
  end

  def create
    create! do |format|
      format.json { render partial: 'model', locals: { comment: resource.decorate } }
    end
  end

  def new
    new! do |format|
      format.html { render partial: 'form' }
    end
  end


end
