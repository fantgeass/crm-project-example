# == Schema Information
#
# Table name: questions
#
#  id                    :integer          not null, primary key
#  questionable_id       :integer
#  questionable_type     :string(255)
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

class Question < AbstractActiveRecord
  include Taskable
  belongs_to :questionable, polymorphic: true

  before_save ThroughAttachmentableCallbacks.new(:questionable)
end
