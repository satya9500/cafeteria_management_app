class UsersController < ApplicationController
  def new
    render "users/new"
  end

  def create
    user = User.new(
      email: params[:email],
      name: params[:name],
      role: params[:role],
      password: params[:password]
      )
    if user.save
      session[:current_user_id] = user.id
      redirect_to "/"
    else
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end
end
