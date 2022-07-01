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

  def new
   @item = Item.new
  end

  def create
   @item = Item.new(item_params)
   if @item.save!
   redirect_to admin_items_path
   else
   flash[:item_created_error] = "商品情報が正常に保存されませんでした。"
   redirect_to new_admin_item_path
   end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item)
    else
      flash[:item_updated_error] = "商品情報が正常に保存されませんでした。"
      redirect_to edit_admin_item_path(@item)
    end
  end


  private
  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :image, :is_active)
  end
end
