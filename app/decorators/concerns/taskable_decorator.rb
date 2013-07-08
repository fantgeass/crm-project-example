module TaskableDecorator
  extend ActiveSupport::Concern

  included do
    decorates_association :taskable
    decorates_association :attachments
    decorates_association :users
    decorates_association :comment_threads
  end

  def progress_bar
    percentage = source.completeness_percentage
    if !source.is_complete? && percentage > 100
      '<div class="bar bar-danger" style="width: 100%;">Failed</div>'
    elsif !source.is_complete? && percentage <= 100
      '<div class="bar" style="width: '+percentage.to_s+'%;"></div>'
    else
      '<div class="bar bar-success" style="width: 100%;">Completed</div>'
    end
  end

  def stripe_class
    if source.priority_high?
      'stripe-urgent'
    elsif source.priority_medium?
      'stripe-low'
    else
      ''
    end
  end

  def planned_start_date
    empty_date(source.planned_start_date, format: :near_date)
  end

  def planned_complete_date
    empty_date(source.planned_complete_date, format: :near_date)
  end

  def link_to_open(parent)
    url = send("open_#{parent.class.name.downcase}_#{source.class.name.downcase}_path", parent, source)
    link_to '', url, method: :put, class: 'action action-pause', title: t(:open)
  end

  def link_to_complete(parent)
    url = send("complete_#{parent.class.name.downcase}_#{source.class.name.downcase}_path", parent, source)
    link_to '', url, method: :put, class: 'action action-mark-done', title: t(:complete)
  end


end