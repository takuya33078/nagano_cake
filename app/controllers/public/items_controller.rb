class Public::ItemsController < ApplicationController
 def show
 end

 def index
  @genres = Genre.all
  @items_all = Item.all

 end
end
