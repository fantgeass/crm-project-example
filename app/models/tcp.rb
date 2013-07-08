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

class Tcp < AbstractActiveRecord
  include Projectable

  has_many :through_attachmentizations, class_name: Attachmentization.name, as: :through_attachmentable
  has_many :related_attachments, class_name: Attachment.name,
           through: :through_attachmentizations, source: :attachment, uniq: true

  def create_project
    raise 'You can not create project unless status is completed' unless state_completed?

    params = {
      id: id,
      company_id: company_id,
      client_id: client_id,
      title: title,
      description: description,
    }

    project = Project.new(params, without_protection: true)
    self.staff.each do |member|
      project.staff << StaffMember.new(
        staff_role_id: member.staff_role_id,
        user_id: member.user_id
      )
    end
    project.save!

    return project
  end
end
