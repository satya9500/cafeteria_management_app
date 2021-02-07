class OrdersController < ApplicationController
  before_action :ensure_user_logged_in
  before_action :ensure_clerk_or_owner, only: [:update, :ordersAll]

  def index
    @orders = @current_user.orders
    render "orders/index"
  end

  def destroyItemFromCart
    menu_item_id = params[:menu_item_id]
    for cart_item in session[:cart]
      if cart_item["menu_item_id"].to_s == menu_item_id.to_s
        session[:cart] = session[:cart] - [cart_item]
        redirect_to main_path and return
      end
    end
  end

  def storeItemsInCart
    menu_item_id = params[:menu_item_id]
    menu_item = MenuItem.find_by_id(menu_item_id)
    menu_item_name = menu_item.name
    menu_item_price = menu_item.price

    quantity = params[:quantity]
    if quantity.to_i <= 0
      flash[:error] = "The quantity must be greater than zero"
      redirect_to main_path and return
    end

    for cart_item in session[:cart]
      if cart_item["menu_item_id"].to_s == menu_item_id.to_s
        cart_item[:quantity] = params[:quantity]
        cart_item[:amount] = menu_item.price.to_i * quantity.to_i
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
    puts @current_user.role
    if session[:cart].length <= 0
      flash[:error] = "You must select some items first"
      redirect_to main_path and return
    end
    order_type = "walk-in"
    order_status = "pending"
    if @current_user.role == "customer"
      order_type = "online"
    end
    total_price = 0
    for order_item in session[:cart]
      total_price = total_price + order_item["amount"]
    end
    order = Order.new({
      :user_id => @current_user.id,
      :order_type => order_type,
      :status => order_status,
      :date => DateTime.now,
      :delivered_at => nil,
      :total_price => total_price,
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

  def update
    id = params[:id]
    order = Order.find(id)
    if order.status == "delivered"
      flash[:error] = "This order is already delivered"
      redirect_to orders_all_path and return
    end
    order.status = "delivered"
    order.delivered_at = DateTime.now
    order.save
    redirect_to orders_all_path
  end

  def ordersAll
    @all_orders = Order.joins(:user).all
    render "orders/all"
  end
end
