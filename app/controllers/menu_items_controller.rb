class MenuItemsController < ApplicationController
  before_action :ensure_user_logged_in
  before_action :ensure_user_is_owner

  def create
    menu_id = params[:menu_id]
    MenuItem.create(
      menu_id: menu_id,
      name: params[:menu_item_name],
      description: params[:menu_item_description],
      price: params[:menu_item_price],
    )
    redirect_to "/menus/#{menu_id}"
  end
end
