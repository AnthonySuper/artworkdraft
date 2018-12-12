class UsersController < ApplicationController

  before_action :load_user, only: 
    [:show, :edit, :update, :destroy, :feed, :verify_email, :unsubscribe]

  def show
  end

  def feed
  end

  def verify_email
    token = params[:auth_token]
    if token != @user.email_confirmation_token
      redirect_to root_path
    elsif @user.update(email_confirmed: true)
      flash[:notice] = "Email confirmed!"
      redirect_to @user
    else
      redirect_to root_path
    end
  end

  def unsubscribe
    token = params[:unsubscribe_token]
    if token != @user.unsubscribe_token || token.nil?
      redirect_to root_path
    elsif @user.unsubscribe_from_everything!
      flash[:notice] = "Unsubscribed from all email notifications"
      redirect_to @user
    else
      redirect_to root_path
    end
  end

  def index 
    @users = paginate(policy_scope(User.all))
    authorize @users
  end  

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_create_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user }
        format.json { render @user }
      end
        format.html { render 'new' }
        format.json { render @user.errors }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user }
        format.json { render @user }
      else
        format.html { render 'edit' }
        format.json { render @user.errors }
      end
    end
  end

  protected

  def user_create_params
    params
      .require(:user)
      .permit(:name, :email, :password, :password_confirmation)
  end

  def user_params
    params
      .require(:user)
      .permit(:bio, :avatar, prefs: [:nsfw],
              notification_email_prefs: notification_email_prefs_params)
  end

  def notification_email_prefs_params
    [:user_followed, :user_commented, :user_reblogged]
  end

  def load_user
    @user = policy_scope(User).find(params[:id])
    authorize @user
  end
end
