class Public::OrdersController < ApplicationController

  # 注文情報入力
  def new
    @order = Order.new
  end

  # 注文情報確認
  def confirm
    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    @order.payment_method = params[:order][:payment_method]
    @order.postage = 800
    # 会員住所
    if params[:order][:select_address] == "0"
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
      render :confirm
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.post_code = @address.post_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:select_address] == "2"
      @order.post_code = @order.post_code
      @order.address = @order.address
      @order.name = @order.name
    else
      render :new
    end
  end

  # 注文完了
  def complete
  end

  # 注文確定
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if @order.save
      @cart_items = current_customer.cart_items
      
      @cart_items.each do |cart_item|   #カートアイテムをひとつずつ取り出す
        @order_detail = @order.order_details.new  #order_detailの空の箱を用意
        @order_detail.order_id = @order.id  #orderのidをorder_detailのidに代入
        @order_detail.item_id = cart_item.item_id  #カートアイテムのアイテムidをorder_detailのアイテムidに代入
        @order_detail.price = cart_item.item.with_tax  #カートアイテムに保存されている金額をorder_detailのpriceheに代入(with_taxで税込み価格にしている)
        @order_detail.quantity = cart_item.quantity  #カートアイテムに保存されている数量を @order_detailのquantityに代入
        @order_detail.production_status = "waiting_start"
        
        @order_detail.save
      end
      
      @cart_items.destroy_all
      redirect_to orders_complete_path
    else
      render :new
    end
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @order_lists = @order.order_details
  end

  private

  def order_params
    params.require(:order).permit(:postage, :payment_method, :name, :address, :post_code, :customer_id, :total, :order_status)
  end

  def address_params
    params.require(:order).permit(:post_code, :address, :name)
  end
end