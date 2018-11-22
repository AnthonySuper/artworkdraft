FactoryBot.define do
  factory :scrap do
    user factory: :user
    name { "MyText" }
    description { "MyText" }
    nsfw { false }
  end
end
