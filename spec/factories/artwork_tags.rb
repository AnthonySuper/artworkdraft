FactoryBot.define do
  factory :artwork_tag do
    artwork factory: :artwork
    tag factory: :tag
  end
end
