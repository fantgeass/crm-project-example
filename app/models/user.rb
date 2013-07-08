# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  company_id             :integer
#  department_id          :integer
#  position_id            :integer
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  fullname               :string(255)
#  gender                 :string(255)
#  phone                  :string(255)
#  about                  :text
#  date_of_birth          :date
#  salary                 :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  creator_id             :integer
#  updater_id             :integer
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#

class User < AbstractActiveRecord
  extend Enumerize

  model_stamper # userstamp
  rolify

  enumerize :gender, in: [:male, :female]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :avatar, :fullname, :gender, :phone, :about, :date_of_birth,
                  :salary, :company_id, :department_id, :position_id

  belongs_to :department
  belongs_to :position
  belongs_to :company
  has_many :staff, class_name: StaffMember.name
  has_many :staff_tcps, through: :staff, source: :staffable, source_type: Tcp.name
  has_many :created_tcps, class_name: Tcp.name, foreign_key: :creator_id
  has_many :staff_projects, through: :staff, source: :staffable, source_type: Project.name
  has_many :created_projects, class_name: Project.name, foreign_key: :creator_id
  has_many :userizations
  has_many :tasks, through: :userizations, source: :userable, source_type: Task.name
  has_many :questions, through: :userizations, source: :userable, source_type: Question.name
  has_attached_file :avatar, styles: {medium: '139x132>', thumb: '45x46>'}

  validates_presence_of :fullname, :email, :company_id, :department_id, :position_id

  delegate :title, to: :department, prefix: true, allow_nil: true
  delegate :title, to: :position, prefix: true, allow_nil: true

  # get staff_tcps & created_tcps
  def tcps
    Tcp.joins(:staff).where(['tcps.creator_id = :uid OR staff.user_id = :uid', uid: self.id]).uniq
  end

  def tcps_count
    tcps.count(nil, distinct: true)
  end

  # get staff_projects & created_projects
  def projects
    Project.joins(:staff).where(['projects.creator_id = :uid OR staff.user_id = :uid', uid: self.id]).uniq
  end

  def projects_count
    projects.count(nil, distinct: true)
  end

  def to_s
    fullname
  end

end
