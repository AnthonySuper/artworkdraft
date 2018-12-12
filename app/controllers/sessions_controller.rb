class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User
      .find_by(email: login_params[:email])
      .try(:authenticate, login_params[:password])
    if @user.nil? then 
      redirect_to new_session_path
    elsif @user.email_confirmed?
      flash[:notice] = "Signed in"
      session[:user_id] = @user.id
      redirect_back(fallback_location: "/")
    else
      flash[:alert] = "Email not confirmed. Please check your email."
      redirect_back(fallback_location: "/")
    end
  end

  def logout
    session[:user_id] = nil
    redirect_back(fallback_location: "/")
  end

  protected
  def login_params
    params.require(:login).permit(:email, :password)
  end
end
