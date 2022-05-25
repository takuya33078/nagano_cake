class Admin::HomesController < ApplicationController
  
  def top
    @Items = Item.page(params[:page]).per(10)
  end
end
