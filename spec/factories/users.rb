FactoryGirl.define do
  factory :user do
    name { generate(:name) }
    email { generate(:email) }
    password { generate(:password) }

    trait :with_messages do
      transient do
        num 5
      end

      after(:create) do |user, evaluator|
        create_list(:message, evaluator.num, user: user)
      end
    end

    trait :with_followers do
      transient do
        num 5
      end

      after(:create) do |user, evaluator|
        evaluator.num.times do
          user.followers.push create(:user)
        end

        user.save
      end
    end

    trait :with_followings do
      transient do
        num 5
      end

      after(:create) do |user, evaluator|
        evaluator.num.times do
          user.followings.push create(:user)
        end

        user.save
      end
    end
  end
end