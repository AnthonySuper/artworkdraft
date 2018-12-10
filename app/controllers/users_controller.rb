class UsersController < ApplicationController

  before_action :load_user, only: 
    [:show, :edit, :update, :destroy, :feed]

  def show
  end

  def feed
  end

  def index 
    @users = User.all
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
      .permit(:bio, :avatar, prefs: [:nsfw])
  end

  def load_user
    @user = policy_scope(User).find(params[:id])
    authorize @user
  end
end
