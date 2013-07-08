# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tcp do
    company_id 1
    client_id 1
    title "MyString"
    description "MyString"
    state "active"
  end
end
