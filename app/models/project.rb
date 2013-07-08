# == Schema Information
#
# Table name: projects
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

class Project < AbstractActiveRecord
  include Projectable

  belongs_to :tcp, foreign_key: 'id'

  # get tcps attachments too
  has_many :through_attachmentizations, class_name: Attachmentization.name, foreign_key: :through_attachmentable_id
  has_many :related_attachments, class_name: Attachment.name,
           through: :through_attachmentizations, source: :attachment, uniq: true


end
