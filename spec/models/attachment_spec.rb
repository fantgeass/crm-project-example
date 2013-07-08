# == Schema Information
#
# Table name: attachments
#
#  id                     :integer          not null, primary key
#  attachment_category_id :integer
#  attachment_job_type_id :integer
#  title                  :string(255)
#  description            :text
#  start_date             :date
#  finish_date            :date
#  accessible             :boolean
#  file_file_name         :string(255)
#  file_content_type      :string(255)
#  file_file_size         :integer
#  file_updated_at        :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  creator_id             :integer
#  updater_id             :integer
#

require 'spec_helper'

describe Attachment do
  describe 'Associations' do
    it { should belong_to(:attachment_category) }
    it { should belong_to(:attachment_job_type) }
    it { should have_many(:tcps) }
  end

  describe 'Delegations' do
    it { should respond_to(:attachment_category_title) }
    it { should respond_to(:attachment_job_type_title) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:attachment_category_id) }
    it { should validate_presence_of(:attachment_job_type_id) }
  end
end
