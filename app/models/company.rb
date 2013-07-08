# == Schema Information
#
# Table name: companies
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  address     :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  creator_id  :integer
#  updater_id  :integer
#

class Company < ActiveRecord::Base
  attr_accessible :address, :description, :title

  has_many :tcps
  has_many :projects
  has_many :users

  validates_presence_of :title

  def to_s
    title
  end
end
