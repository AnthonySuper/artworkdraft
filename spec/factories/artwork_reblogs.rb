FactoryBot.define do
  factory :artwork_reblog do
    user { nil }
    artwork { nil }
    path { "" }
    comment { "MyText" }
  end
end
