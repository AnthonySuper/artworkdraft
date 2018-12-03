FactoryBot.define do
  factory :artwork do
    name { "MyText" }
    description { "MyText" }
    nsfw { false }
    user factory: :user
    image { FilesTestHelper.png }

    trait :nsfw do 
      nsfw { true }
    end
  end
end
