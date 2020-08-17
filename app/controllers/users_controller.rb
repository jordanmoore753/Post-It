class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'Successfully registered user.'
      redirect_to root_path
    else
      render :new
    end
  end

  def show

  end

  def edit

  end

  def update
    if @user.update(user_params_update)
      flash[:notice] = 'Profile updated.'
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

  def user_params_update
    params.require(:user).permit(:username, :password)
  end

  def correct_user
    if session[:user_id] != params[:id].to_i
      flash[:error] = 'You are not authorized to do that.'
      redirect_to root_path
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end