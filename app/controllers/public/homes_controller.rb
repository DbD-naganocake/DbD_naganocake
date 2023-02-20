class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all
    @items = Item.all.order(created_at: "DESC")
  end

  def about
  end
  
  private
  
  def item_params
    params.require(:item).permit(:item_image, :item_name, :without_tax)
  end
  
end
