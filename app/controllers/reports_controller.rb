class ReportsController < ApplicationController
  before_action :ensure_user_logged_in

  def index
    @all_orders = Order.all
    render "reports/index"
  end

  def order_details
    order_id = params[:order_id]
    @order_items_report = OrderItem.all.where(order_id: order_id)
    render "reports/order_details"
  end

  def range_query_report
    @all_orders = Order.where("user_id=? AND date BETWEEN ? AND ?", params[:user_id], params[:start_date], params[:end_date])
    puts @all_orders
    render "reports/index"
  end
end
