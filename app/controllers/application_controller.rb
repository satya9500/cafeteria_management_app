class ApplicationController < ActionController::Base
  before_action :ensure_user_logged_in, only: [:ensure_clerk_or_owner, :ensure_owner]

  def ensure_user_logged_in
    unless current_user
      flash[:error] = "You must be logged in to access this section"
      redirect_to "/"
    end
  end

  def ensure_user_not_logged_in
    if current_user
      flash[:error] = "You need to logout first!"
      redirect_to "/"
    end
  end

  def ensure_clerk_or_owner
    unless @current_user.is_owner or @current_user.is_clerk
      flash[:error] = "You role is not authorized to perform this action."
      redirect_to "/"
    end
  end

  def ensure_owner
    unless @current_user.is_owner
      flash[:error] = "You role is not authorized to perform this action."
      redirect_to "/"
    end
  end

  def current_user
    return @current_user if @current_user
    current_user_id = session[:current_user_id]
    if current_user_id
      @current_user = User.find(current_user_id)
      return @current_user
    else
      nil
    end
  end
end
