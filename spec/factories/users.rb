# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "username-#{n}" }
    sequence(:email) { |n| "username-#{n}@example.com" }
    password "secret"
    password_confirmation "secret"
    need_invitation false

    factory :admin do
      roles { [build(:admin_role)] }
    end

    factory :editor do
      roles { [build(:editor_role)] }
    end

    factory :user_with_codes do
      invite_codes { [build(:invite_code), build(:invite_code)] }
    end
  end
end
