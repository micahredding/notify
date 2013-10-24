# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rule do
    name "MyString"
    sender_regex "MyText"
    subject_regex "MyText"
    content_regex "MyText"
  end
end
