# == Schema Information
#
# Table name: tcps
#
#  id                    :integer          not null, primary key
#  company_id            :integer
#  client_id             :integer
#  title                 :string(255)
#  description           :text
#  state                 :string(255)
#  complete_date         :date
#  planned_start_date    :date
#  planned_complete_date :date
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  creator_id            :integer
#  updater_id            :integer
#

require 'spec_helper'

describe Tcp do
  describe 'Associations' do
    it { should belong_to(:company) }
    it { should belong_to(:client).class_name(User.name) }
    it { should have_many(:tasks) }
    it { should have_many(:questions) }
    it { should have_many(:comment_threads) }
    it { should have_many(:staff) }
    it { should have_many(:users).through(:staff) }
    it { should have_many(:attachmentizations) }
    it { should have_many(:attachments).through(:attachmentizations) }
    it { should have_many(:tasks_attachments).class_name(Attachment.name).through(:tasks) }
    it { should have_many(:tasks_comment_threads).class_name(Comment.name).through(:tasks) }
    it { should have_many(:tasks_comment_threads_attachments).class_name(Attachment.name).through(:tasks_comment_threads) }
    it { should have_many(:questions_attachments).class_name(Attachment.name).through(:questions) }
    it { should have_many(:questions_comment_threads).class_name(Comment.name).through(:questions) }
    it { should have_many(:questions_comment_threads_attachments).class_name(Attachment.name).through(:questions_comment_threads) }
    it { should have_many(:comment_threads_attachments).class_name(Attachment.name).through(:comment_threads) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:company_id) }
    it { should validate_presence_of(:client_id) }
    it { should validate_presence_of(:staff) }
  end

  #describe '#create_project' do
  #  let(:tcp) { FactoryGirl.create :tcp }
  #  expect { tcp.create_project }.to raise_error 'You can not create project unless status is completed'
  #end


end
