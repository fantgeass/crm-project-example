# == Schema Information
#
# Table name: userizations
#
#  userable_id   :integer
#  userable_type :string(255)
#  user_id       :integer
#

class Userization < ActiveRecord::Base
  belongs_to :userable, polymorphic: true
  belongs_to :user
end
