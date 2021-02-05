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
end
