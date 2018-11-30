FactoryBot.define do
  factory :artwork_comment do
    user { nil }
    body { "MyText" }
    artwork { nil }
  end
end
