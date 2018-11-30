FactoryBot.define do
  factory :scrap_tag do
    scrap factory: :scrap 
    tag factory: :tag
  end
end
