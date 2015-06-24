RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

FactoryGirl.define do
  sequence(:name) { |n| "Name# {n}" }

  sequence(:email) { |n| "user#{n}@domain.tld" }

  sequence(:login) { |n| "login#{n}" }

  sequence(:password) { |n| "Password#{n}" }

  sequence(:text) { |n| "Lorem ipsum dolor sit amet #{n}." }
end