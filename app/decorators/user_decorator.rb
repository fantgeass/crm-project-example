class UserDecorator < ApplicationDecorator
  decorates_association :tasks

  def date_of_birth
    l source.date_of_birth, format: :long
  end

  def avatar_tag
    image_tag source.avatar.url(:thumb), alt: source, class: 'user-avatar'
  end

  def avatar_url
    source.avatar.url(:thumb)
  end

  def link_avatar_tag
    link_to avatar_tag, user_path(source), title: model, class: 'avatar'
  end

  def department_title
    empty_value source.department_title
  end

  def position_title
    empty_value source.position_title
  end

  def to_s
    source.to_s
  end

end
