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

class Attachment < AbstractActiveRecord
  attr_accessible :description, :finish_date, :start_date, :title, :file, :accessible,
                  :attachment_category_id, :attachment_job_type_id

  belongs_to :attachment_category
  belongs_to :attachment_job_type
  has_many :attachmentizations
  has_many :tcps, through: :attachmentizations, source_type: Tcp.name, source: :attachmentable
  has_many :projects, through: :attachmentizations, source_type: Project.name, source: :attachmentable
  has_attached_file :file

  delegate :title, to: :attachment_category, prefix: true
  delegate :title, to: :attachment_job_type, prefix: true

  validates_presence_of :title, :attachment_category_id, :attachment_job_type_id, :file
  validates_attachment_presence :file


  scope :title_or_desc, lambda { |string| search_for string, on: [:title, :description] }


  def self.get_content_types
    select(:file_content_type).uniq.map(&:file_content_type)
  end
end
