FactoryBot.define do
  factory :scrap_comment do
    user factory: :user
    body { "MyText" }
    scrap factory: :scrap
  end
end
