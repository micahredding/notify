# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gmail_account do
    user_id 1
    email "MyString"
    token "MyString"
  end
end
