class MenuItemsController < ApplicationController
  before_action :ensure_user_logged_in
  before_action :ensure_owner

  def show
    id = params[:id]
    @menu_item = MenuItem.find(id)
    render "/menus/menu_item"
  end

  def update
    id = params[:id]
    menu_item = MenuItem.find(id)
    if params[:menu_item_name]
      menu_item.name = params[:menu_item_name]
    end
    if params[:menu_item_description]
      menu_item.description = params[:menu_item_description]
    end
    if params[:menu_item_price]
      menu_item.price = params[:menu_item_price]
    end
    if params[:menu_item_image]
      menu_item.image = params[:menu_item_image]
    end
    if !menu_item.save
      flash[:error] = menu_item.errors.full_messages.join(", ")
    end
    redirect_to "#{menus_path}/#{menu_item.menu_id}"
  end

  def create
    menu_id = params[:menu_id]
    menu_item = MenuItem.new(
      menu_id: menu_id,
      name: params[:menu_item_name],
      description: params[:menu_item_description],
      price: params[:menu_item_price],
      image: params[:menu_item_image],
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
