namespace :users do
  desc "Resend validation emails for all users"
  task resend_verify: :environment do
    User.where(email_confirmed: false).each do |user|
      if user.email_confirmation_token.nil?
        user.regenerate_email_confirmation_token
      end
      user.verify_email!(false)
    end
  end

  task generate_unsubscribe: :environment do
    User.where(unsubscribe_token: nil).each do |user|
      user.regenerate_unsubscribe_token
    end
  end
end
