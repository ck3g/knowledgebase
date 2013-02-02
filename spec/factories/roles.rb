

FactoryGirl.define do
  factory :role do
    user
    name "admin"

    factory :admin_role do
      name "admin"
    end
  end
end
