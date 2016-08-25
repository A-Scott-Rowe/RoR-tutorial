class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      check_if_user_activated user
    else
      flash_login_failed
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def create_user_session(user)
    log_in user
    params[:session][:remember_me] == '1' ? remember(user) : forget(user)
    redirect_back_or user
  end

  def flash_login_failed
    flash.now[:danger] = 'Invalid email/password combination'
    render 'new'
  end

  def check_if_user_activated(user)
    if user.activated?
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      message = 'Account not activated. Check your email for the activation link.'
      flash[:warning] = message
      redirect_to root_url
    end
  end
end
