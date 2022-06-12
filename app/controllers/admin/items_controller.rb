class Admin::ItemsController < ApplicationController
  def index
  	@genres = Genre.where(is_enabled: true)
   if params[:genre_id]
    @genre = Genre.find(params[:genre_id])
    @items = @genre.items.order(created_at: :desc).where(is_active: "販売可").page(params[:page]).per(8)
   else
    @items = Item.where(is_active: "販売可").page(params[:page]).per(12)
   end
  end

  def show
    @cart_item = CartItem.new
  	@genres = Genre.all
  	@item = Item.find(params[:id])
  end
  
  def new
    @item = Item.new
  end
  
  def create
   @item = Item.new(item_params)
   if @item.save
   redirect_to admin_items_path
   else
   flash[:item_created_error] = "商品情報が正常に保存されませんでした。"
   redirect_to new_admin_item_path
   end
  end

  private
  def item_params
    params.require(:item).permit(:genre_id, :name, :description, :price_without_tax, :image, :is_active)
  end
end
