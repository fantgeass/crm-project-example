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

require 'spec_helper'

describe Department do
  describe 'Associations' do
    it { should have_many(:users) }
  end
  describe 'Validations' do
    it { should validate_presence_of(:title) }
  end
end
