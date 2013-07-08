# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    references ""
    title "MyString"
    description "MyText"
    state "MyString"
    planned_finish_date "2012-12-27"
    actual_finish_date "2012-12-27"
  end
end
