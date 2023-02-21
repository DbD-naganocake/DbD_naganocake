class Public::CartItemsController < ApplicationController
  # カート内一覧
  def index
    @cart_items = CartItem.all
  end
  # カート内商品追加
  def create
    @cart_item = CartItem.new(cart_item_params)
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.quantity += params[:cart_item][:quantity].to_i
      cart_item.save!
    else
      @cart_item.customer_id = current_customer.id
      @cart_item.save!
    end
    @cart_items = CartItem.all
    redirect_to cart_items_path
  end

  # カート更新
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    @cart_items = CartItem.all
    redirect_to cart_items_path
  end

  # カート内１つ削除
  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    @cart_items = CartItem.all
    redirect_to cart_items_path
  end

  # カート内全て削除
  def destroy_all
    cart_items = CartItem.all
    cart_items.destroy_all
    redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :without_tax, :quantity)
  end

end
