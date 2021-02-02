class SessionsController < ApplicationController
  def new
    render "sessions/new"
  end

  def index
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      session[:current_user_role] = user.role
      redirect_to "/"
    else
      flash[:error] = "Your login attempt was invalid. Please retry."
      redirect_to new_sessions_path
    end
  end

  def destroy
    before_action :ensure_user_logged_in
    session[:current_user_id] = nil
    @current_user = nil
    redirect_to "/"
  end
end
