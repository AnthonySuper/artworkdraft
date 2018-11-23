class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def index 
    @users = User.all
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


  protected

  def user_create_params
    params
      .require(:user)
      .permit(:name, :email, :password, :password_confirmation)
  end
end
