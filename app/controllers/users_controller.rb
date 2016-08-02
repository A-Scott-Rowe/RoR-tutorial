class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = 'Welcome to the Sample App!'
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params
      flash[:success] = 'User Successfuly Updated!'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate page: params[:page]
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = 'Please log in!'
    redirect_to login_url
  end

  def correct_user
    @user = User.find params[:id]
    redirect_to root_url unless @user == current_user
  end
end
