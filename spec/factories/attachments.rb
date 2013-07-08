# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attachment do
    attachmentable nil
    title "MyString"
    description "MyText"
    start_date "2012-12-27"
    finish_date "2012-12-27"
  end
end
