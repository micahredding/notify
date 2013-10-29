# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rule do
    name "New Rule"
    notification_text "This is a notification"
  end
end
