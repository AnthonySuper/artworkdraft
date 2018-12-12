class NotifierMailer < ApplicationMailer
  default from: "notifications@artworkdraft.com"
  before_action {
    @user = params[:user]
    @data = params[:data]
  }

  def user_followed
    mail(to: @user.email, subject: "You've got a new follower on ArtWorkDraft!")
  end

  def user_commented
    mail(to: @user.email, subject: "Somebody left a comment on your work on ArtWorkDraft")
  end
end
