class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(params[:id], :activation)
      activate_user user
      flash[:success] = 'Account activated!'
      redirect_to user
    else
      flash[:danger] = 'Invalid activation link'
      redirect_to root_url
    end
  end
end

private

def activate_user(user)
  user.update_attribute(:activated,    true)
  user.update_attribute(:activated_at, Time.zone.now)
  log_in user
end
