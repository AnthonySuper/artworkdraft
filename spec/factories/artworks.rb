FactoryBot.define do
  factory :artwork do
    name { "MyText" }
    description { "MyText" }
    nsfw { "" }
    user { nil }
  end
end
