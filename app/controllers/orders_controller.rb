class OrdersController < ApplicationController
  def storeItems
    menu_id = params[:menu_id]
    menu_item_id = params[:menu_item_id]
    menu_item_name = params[:menu_item_name]
    menu_item_price = params[:menu_item_price]
    @current_user[:order_items].push({
      menu_id: params[:menu_id],
      menu_item_id: params[:menu_item_id],
      menu_item_name: params[:menu_item_name],
      menu_item_price: params[:menu_item_price],
    })
    puts @current_user
    redirect_to main_path
  end
end
