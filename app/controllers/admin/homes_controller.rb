class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @Items = Item.page(params[:page]).per(10)
    @orders = Order.all
  end
end
