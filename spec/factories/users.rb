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
    notification_email_prefs do
      { user_followed: true, user_commented: true, user_reblogged: true }
    end
  end
end
