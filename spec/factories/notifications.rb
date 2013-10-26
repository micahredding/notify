# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification do
    user_id 1
    gmail_account_id 1
    email_id 1
    body "MyText"
    read false
  end
end
