# == Schema Information
#
# Table name: attachmentizations
#
#  id                          :integer          not null, primary key
#  attachmentable_id           :integer
#  attachmentable_type         :string(255)
#  through_attachmentable_id   :integer
#  through_attachmentable_type :string(255)
#  attachment_id               :integer
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  creator_id                  :integer
#  updater_id                  :integer
#

class Attachmentization < AbstractActiveRecord
  belongs_to :attachmentable, polymorphic: true
  belongs_to :through_attachmentable, polymorphic: true
  belongs_to :attachment
end
