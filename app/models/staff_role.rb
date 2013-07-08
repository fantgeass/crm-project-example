# == Schema Information
#
# Table name: staff_roles
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  creator_id  :integer
#  updater_id  :integer
#

class StaffRole < AbstractActiveRecord
  attr_accessible :title, :description

  has_many :staff
end
