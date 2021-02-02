class MainController < ApplicationController
  before_action :ensure_user_logged_in

  def index
    if current_user
      @all_active_items = MenuItem.includes(:menu).where(menu: { is_active: true })
      render "main/index"
    else
      redirect_to "/"
    end
  end
end
