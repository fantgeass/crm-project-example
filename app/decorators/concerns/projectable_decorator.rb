module ProjectableDecorator
  extend ActiveSupport::Concern

  included do
    decorates_association :attachments
    decorates_association :staff
    decorates_association :users
  end

  def progress_bar
    percentage = source.completeness_percentage
    if source.state_active? && percentage > 100
      '<div class="bar bar-danger" style="width: 100%;">Failed</div>'
    elsif source.state_active? && percentage <= 100
      '<div class="bar" style="width: '+percentage.to_s+'%;"></div>'
    elsif source.state_completed?
      '<div class="bar bar-success" style="width: 100%;">Completed</div>'
    elsif source.state_closed?
      '<div class="bar bar-danger" style="width: 100%;">Closed</div>'
    end
  end

  def planned_start_date
    empty_date(source.planned_start_date, format: :near_date)
  end

  def planned_complete_date
    empty_date(source.planned_complete_date, format: :near_date)
  end

  def complete_date
    source.complete_date ? l(source.complete_date, format: :long) : t(:empty)
  end

  def completeness_days
    if source.planned_complete_date.nil?
      t(:empty)
    else
      distance_of_time_in_words(Date.today, source.planned_complete_date)
    end
  end

  def to_s
    source.to_s
  end


end