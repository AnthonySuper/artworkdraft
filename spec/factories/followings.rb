FactoryBot.define do
  factory :following do
    followee factory: :user
    follower factory: :user
  end
end
