module TaskableController
  extend ActiveSupport::Concern

  included do
    respond_to :json
    layout  :choose_parent_layout, only: [:show, :index, :new, :edit]

    custom_actions resource: [:open, :complete]

    has_scope :page, default: 1
    has_scope :per, default: 10
    has_scope :is_complete_equals, as: :is_complete
    has_scope :order, default: 'is_complete, planned_start_date'

    belongs_to :tcp, :project, polymorphic: true, optional: true

    def complete
      complete! do |format|
        resource.complete
        format.html { redirect_to request.referrer }
      end
    end

    def open
      open! do |format|
        resource.open
        format.html { redirect_to request.referrer }
      end
    end
  end

end