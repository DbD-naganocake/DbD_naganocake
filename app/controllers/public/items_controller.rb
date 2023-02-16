class Public::ItemsController < ApplicationController
  def index
    @item = Item.new
    @items = Item.page(params[:page]).per(8)
    @genres = Genre.where(status: true)
  end

  def show
  end

  private
  def item_params
    params.require(:item).permit(:item_name, :item_image, :without_tax)
  end
end
