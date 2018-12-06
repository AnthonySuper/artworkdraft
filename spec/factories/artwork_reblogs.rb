FactoryBot.define do
  factory :artwork_reblog do
    user factory: :user
    artwork factory: :artwork
    comment { "Comment" }

    trait :recursive do
      ancestor_id { create(:artwork_reblog).id }
      artwork { nil }
    end
  end
end
