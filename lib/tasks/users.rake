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
end
