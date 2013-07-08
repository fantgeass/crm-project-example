# == Schema Information
#
# Table name: staff
#
#  id             :integer          not null, primary key
#  staffable_id   :integer
#  staffable_type :string(255)
#  staff_role_id  :integer
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  creator_id     :integer
#  updater_id     :integer
#

class StaffMember < AbstractActiveRecord
  attr_accessible :staff_role_id, :user_id

  belongs_to :staffable, polymorphic: true
  belongs_to :staff_role
  belongs_to :user

  delegate :title, to: :staff_role, prefix: true
  delegate :fullname, :email, :phone, to: :user, prefix: true

  validates_presence_of :user_id, :staff_role_id

end
