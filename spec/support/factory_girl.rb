RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

FactoryGirl.define do
  to_create do |instance|
    raise "Invalid record: #{instance.errors.full_messages.join(', ')}" unless instance.save
  end

  sequence(:name) { |n| "Name# {n}" }

  sequence(:email) { |n| "user#{n}@domain.tld" }

  sequence(:login) { |n| "login#{n}" }

  sequence(:password) { |n| "Password#{n}" }

  sequence(:text) { |n| "Lorem ipsum dolor sit amet #{n}." }
end