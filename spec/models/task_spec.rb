# == Schema Information
#
# Table name: tasks
#
#  id                    :integer          not null, primary key
#  taskable_id           :integer
#  taskable_type         :string(255)
#  title                 :string(255)
#  description           :text
#  planned_start_date    :date
#  planned_complete_date :date
#  priority              :string(255)
#  is_complete           :boolean          default(FALSE), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  creator_id            :integer
#  updater_id            :integer
#

require 'spec_helper'

describe Task do
  describe 'Associations' do
    it { should belong_to(:taskable) }
    it { should have_many(:comment_threads) }
    it { should have_many(:attachments) }
    it { should have_many(:users) }
    it { should have_and_belong_to_many(:to_tasks) }
    it { should have_and_belong_to_many(:from_tasks) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:title) }
  end
end
