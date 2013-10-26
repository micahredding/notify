# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :email do
    gmail_account_id 1
    date "2013-10-26 15:41:32"
    multipart false
    subject "MyText"
    sender "MyString"
    body "MyText"
  end
end
