FactoryBot.define do
  factory :artwork do
    name { "MyText" }
    description { "MyText" }
    nsfw { false }
    user factory: :user

    trait :nsfw do 
      nsfw { true }
    end
  end
end
