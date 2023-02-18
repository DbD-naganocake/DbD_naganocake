class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
    @genre = Genre.all
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path(@item), notice: "商品を登録しました。"
    else
      render :new
    end
  end

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end
  
  private

  def item_params
    params.require(:item).permit(:item_image, :genre_id, :item_name, :item_caption, :without_tax, :sale_status)
  end
end
