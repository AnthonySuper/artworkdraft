FactoryBot.define do
  factory :artwork_comment do
    user factory: :user
    body { "MyText" }
    artwork factory: :artwork
  end
end
