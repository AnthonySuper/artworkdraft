FactoryBot.define do
  factory :notification do
    user factory: user
    payload { {} }
  end
end
