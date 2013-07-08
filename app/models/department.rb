# == Schema Information
#
# Table name: departments
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  creator_id  :integer
#  updater_id  :integer
#

class Department < AbstractActiveRecord
  attr_accessible :title, :description

  has_many :users

  validates_presence_of :title

  def to_s
    title
  end
end
