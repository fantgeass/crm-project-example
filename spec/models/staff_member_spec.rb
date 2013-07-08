# == Schema Information
#
# Table name: staff
#
#  id             :integer          not null, primary key
#  staffable_id   :integer
#  staffable_type :string(255)
#  staff_role_id  :integer
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  creator_id     :integer
#  updater_id     :integer
#

require 'spec_helper'

describe StaffMember do
  describe 'Associations' do
    it { should belong_to(:staffable)  }
    it { should belong_to(:staff_role) }
    it { should belong_to(:user)       }
  end

  describe 'Validations' do
    it { should validate_presence_of(:staff_role_id) }
    it { should validate_presence_of(:user_id) }
  end



  describe 'Delegations' do
    it { should respond_to(:staff_role_title) }
    it { should respond_to(:user_fullname)    }
    it { should respond_to(:user_email)       }
    it { should respond_to(:user_phone)       }
  end

end
