FactoryBot.define do
  factory :user do 
    sequence :name do |i|
      "user#{i}"
    end

    sequence :email do |i|
      "user#{i}@example.com"
    end

    password { "password" }
    password_confirmation { "password" }
  end
end
