class ApplicationDecorator < Draper::Decorator
  include Draper::LazyHelpers
  delegate_all

  decorates_association :creator
  delegate :avatar_tag, :avatar_url, :link_avatar_tag, to: :creator, prefix: true, allow_nil: true

  def created_at
    l source.created_at, format: :near_date
  end

  def updated_at
    l source.updated_at, format: :near_date
  end

end