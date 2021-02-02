class MenuItemsController < ApplicationController
  before_action :ensure_user_logged_in
  before_action :ensure_user_is_owner

  def create
    menu_id = params[:menu_id]
    menu_item = MenuItem.new(
      menu_id: menu_id,
      name: params[:menu_item_name],
      description: params[:menu_item_description],
      price: params[:menu_item_price],
    )
    if !menu_item.save
      flash[:error] = menu_item.errors.full_messages.join(", ")
    end
    redirect_to "/menus/#{menu_id}"
  end

  def destroy
    menu_id = params[:menu_id]
    menu = MenuItem.find(params[:id])
    menu.destroy!
    redirect_to "/menus/#{menu_id}"
  end
end
