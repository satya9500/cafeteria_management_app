class OrdersController < ApplicationController
  before_action :ensure_user_logged_in

  def index
    @orders = @current_user.orders
    render "orders/index"
  end

  def storeItems
    menu_item_id = params[:menu_item_id]
    menu_item = MenuItem.find_by_id(menu_item_id)
    menu_item_name = menu_item.name
    menu_item_price = menu_item.price

    quantity = params[:quantity]
    if quantity.to_i < 0
      flash[:error] = "The quantity must be greater than zero"
      redirect_to main_path and return
    end

    for cart_item in session[:cart]
      if cart_item["menu_item_id"].to_s == menu_item_id.to_s
        if quantity.to_i <= 0
          session[:cart] = session[:cart] - [cart_item]
        else
          cart_item[:quantity] = params[:quantity]
          cart_item[:amount] = menu_item.price.to_i * quantity.to_i
        end
        redirect_to main_path and return
      end
    end

    session[:cart].push({
      :menu_item_id => menu_item_id,
      :menu_item_name => menu_item_name,
      :menu_item_price => menu_item_price,
      :quantity => quantity,
      :amount => quantity.to_i * menu_item_price.to_i,
    })
    redirect_to main_path
  end

  def create
    if session[:cart].length <= 0
      flash[:error] = "You must select some items first"
      redirect_to main_path and return
    end
    order_type = "walk-in"
    order_status = "pending"
    if @current_user.role == "customer"
      order_type = "online"
    end
    order = Order.new({
      :user_id => @current_user.id,
      :order_type => order_type,
      :status => order_status,
      :date => DateTime.now,
      :delivered_at => nil,
    })
    if !order.save
      flash[:error] = order.errors.full_messages.join(", ")
    end
    all_cart_items = Array.new
    for cart_item in session[:cart]
      temp_order_hash = { :order_id => order.id }
      cart_item.merge!(temp_order_hash)
      all_cart_items.push(cart_item)
    end
    session[:cart] = Array.new
    order_items = OrderItem.create(all_cart_items)
    redirect_to orders_path
  end
end
