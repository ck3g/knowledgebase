# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    question
    content "MyString"
    user_id "MyString"
    accepted false
    rating 0

    factory :invalid_answer do
      content nil
    end
  end
end
