module Taskable
  extend ActiveSupport::Concern

  PRIORITIES = %w(low medium high)
  included do
    attr_accessible :description, :title, :attachment_ids, :user_ids,
                    :priority, :planned_start_date, :planned_complete_date

    acts_as_commentable
    has_many :attachmentizations, as: :attachmentable #
    has_many :attachments, through: :attachmentizations
    has_many :userizations, as: :userable #
    has_many :users, through: :userizations
    has_state :priority

    validates_presence_of :title, :description, :priority
  end

  def open
    update_attribute :is_complete, false
  end

  def complete
    update_attribute :is_complete, true
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

end