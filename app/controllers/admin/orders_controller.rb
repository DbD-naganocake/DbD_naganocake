class Admin::OrdersController < ApplicationController
before_action :authenticate_admin!

  def index
    @orders = Order.page(params[:page]).per(10)
  end

  def current_user_order
    @orders = Order.where(customer_id: params[:id])
  end

  def show
    @order = Order.find(params[:id])
    @order_lists = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: params[:id])
    if @order.update(order_params)
      @order_details.update_all(production_status: 1) if @order.order_status == "payment_confirmation"
    end
    redirect_to admin_order_path(@order)
  end

  private

  def order_params
    params.require(:order).permit(:order_status)
  end
end