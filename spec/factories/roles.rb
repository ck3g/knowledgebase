

FactoryGirl.define do
  factory :role do
    user
    name "admin"

    factory :admin_role do
      name "admin"
    end

    factory :editor_role do
      name "editor"
    end
  end
end
