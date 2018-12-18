FactoryBot.define do
  factory :notification do
    user factory: :user
    payload { {type: "TEST_NOTIFICATION"} }
  end
end
