class EmailValidatorMailer < ApplicationMailer
  default from: "emailverifier@artworkdraft.com"

  def verify_email
    @user = params[:user]
    mail(to: @user.email, subject: "Welcome to ArtWorkDraft!")
  end
end
