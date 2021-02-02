class ApplicationController < ActionController::Base
  def ensure_user_logged_in
    unless current_user
      flash[:error] = "You must be logged in to access this section"
      redirect_to "/"
    end
  end

  def ensure_user_is_clerk
    return match_role("clerk")
  end

  def ensure_user_is_customer
    return match_role("customer")
  end

  def ensure_user_is_owner
    return match_role("owner")
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

  def match_role(role)
    if role == @current_user.role
      return @current_user.role
    else
      flash[:error] = "You role is not authorized to perform this action."
      redirect_to "/"
    end
  end
end
