class Public::ItemsController < ApplicationController
  def index
    @items = Item.where(sale_status: true).page(params[:page]).per(8)
    @genres = Genre.all
      if params[:genre_id].present?
        @genre = Genre.find(params[:genre_id])
        @items = @genre.items.where(sale_status: true).page(params[:page]).per(8)
      end
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
      if params[:genre_id].present?
        @genre = Genre.find(params[:genre_id])
        @items = @genre.items.where(sale_status: true).page(params[:page]).per(8)
      end
  end

  private
  def item_params
    params.require(:item).permit(:item_image, :genre_id, :item_name, :item_caption, :without_tax, :sale_status)
  end
end
