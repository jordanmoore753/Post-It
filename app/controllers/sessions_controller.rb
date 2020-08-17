class SessionsController < ApplicationController
  def new; end

  def create
    user = User.where(username: params[:username]).first

    if user && user.authenticate(params[:password])
      flash[:notice] = 'Successfully logged in.'
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:error] = 'There is something wrong with your username or password.'
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Successfully logged out.'
    redirect_to root_path
  end

  private

  def session_params

  end
end