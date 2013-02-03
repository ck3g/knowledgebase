# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    skill
    title "Question title"
    description { Faker::Lorem.paragraph }
    answered false
    picture "question.png"
  end
end
