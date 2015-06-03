FactoryGirl.define do
  factory :message do
    sequence(:text) { |n| "text #{n}" }
    datetime Time.now
    user
  end
end