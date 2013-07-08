# == Schema Information
#
# Table name: attachment_categories
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  creator_id  :integer
#  updater_id  :integer
#

class AttachmentCategory < AbstractActiveRecord
  attr_accessible :description, :title
end
