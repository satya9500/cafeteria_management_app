class MainController < ApplicationController
  before_action :ensure_user_logged_in

  def index
    if current_user
      render "main/new"
    else
      redirect_to "/"
    end
  end
end
