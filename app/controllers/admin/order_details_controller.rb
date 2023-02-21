class Admin::OrderDetailsController < ApplicationController
before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
  end


  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    @order = @order_detail.order
    @order_details = @order.order_details

    is_updated = true
    if @order_detail.update(order_detail_params)
      @order.update(order_status: 2)if @order_detail.production_status == "in_production"
      @order_details.each do |order_detail|
        if order_detail.production_status != "finish"
          is_updated = false
        end
      end
      @order.update(order_status: 3)if is_updated
    end
    redirect_to admin_order_path(@order)
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:production_status)
  end

end