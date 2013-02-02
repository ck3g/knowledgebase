
FactoryGirl.define do
  factory :skill do
    user
    sequence(:name) { |n| "Skill Name ##{n}" }
    tags { ["ruby", "rails"] }

    factory :invalid_skill do
      name ""
    end
  end
end
