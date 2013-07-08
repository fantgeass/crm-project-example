# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  company_id             :integer
#  department_id          :integer
#  position_id            :integer
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
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
#

require 'spec_helper'

describe User do
  describe 'Associations' do
    it { should belong_to(:department) }
    it { should belong_to(:position) }
    it { should belong_to(:company) }
    it { should have_many(:staff) }
    it { should have_many(:staff_tcps)  }
    it { should have_many(:created_tcps)  }
    it { should have_many(:staff_projects)  }
    it { should have_many(:created_projects)  }
    it { should have_many(:tasks) }
    it { should have_many(:questions) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:company_id) }
    it { should validate_presence_of(:department_id) }
  end

  describe 'Delegations' do
    it { should respond_to(:department_title) }
    it { should respond_to(:position_title) }
  end

end
