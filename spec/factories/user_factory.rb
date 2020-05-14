FactoryBot.define do
  factory :user do
    name {Faker::Name.name}

    trait :takuya do
      name {"takuya"}
    end

    trait :invalid do
      name {nil}
    end
  end

end