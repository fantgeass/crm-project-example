module ProjectableController
  extend ActiveSupport::Concern

  included do
    respond_to :json
    layout 'application', only: [:index, :new, :create, :close, :activate, :complete]

    custom_actions resource: [:close, :activate, :complete, :create_project]

    has_scope :state_equals, default: 'active', only: [:index]
    has_scope :order, default: 'created_at DESC'
    has_scope :page, default: 1, only: [:index]
    has_scope :per, default: 3, only: [:index]


    def close
      close! do
        resource.close
      end
    end

    def activate
      activate! do
        resource.activate
      end
    end

    def complete
      complete! do
        resource.complete
      end
    end

    protected
    def begin_of_association_chain
      if params[:action] == 'index' && params[:show_all].to_i === 0
        @current_user
      end
    end

  end

end