class Public::ItemsController < ApplicationController
  def index
    @item = Item.all
    @items = Item.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
  end

  private
  def item_params
    params.require(:item).permit(:genre_id, :item_name, :item_image, :without_tax)
  end
end
