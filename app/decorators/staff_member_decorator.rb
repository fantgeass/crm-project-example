class StaffMemberDecorator < ApplicationDecorator
  decorates_association :user
  decorates_association :staff_role

  delegate :avatar_tag, :avatar_url, to: :user, prefix: true
end