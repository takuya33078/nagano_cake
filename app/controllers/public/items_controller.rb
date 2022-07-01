class Public::ItemsController < ApplicationController
 def show
   @cart_item = CartItem.new
  	@genres = Genre.all
  	@item = Item.find(params[:id])
 end

 def index
  @items = Item.page(params[:page]).reverse_order
 end


  private
  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :image, :is_active)
  end
end


