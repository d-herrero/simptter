FactoryGirl.define do
  factory :message do
    text { generate(:text) }
    date_time Time.now
    user
  end
end