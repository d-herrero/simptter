FactoryGirl.define do
  factory :user do
    name { generate(:login) }
    email { generate(:email) }
    password { generate(:password) }

    trait :with_messages do
      transient do
        num_messages 5
      end

      after(:create) do |user, evaluator|
        create_list(:message, evaluator.num_messages, user: user)
      end
    end

    trait :with_followers do
      transient do
        num_followers 5
      end

      after(:create) do |user, evaluator|
        evaluator.num_followers.times do
          create(:user_relation, user_id: create(:user).id, following_id: user.id)
        end
      end
    end

    trait :with_followings do
      transient do
        num_followings 5
      end

      after(:create) do |user, evaluator|
        evaluator.num_followings.times do
          create(:user_relation, user_id: user.id, following_id: create(:user).id)
        end
      end
    end
  end

  factory :user_relation do
    user_id nil
    following_id nil
  end
end