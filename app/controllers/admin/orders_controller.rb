class Admin::OrdersController < ApplicationController

def show
  @order = Order.find(params[:id])
  @order_details = @order.order_details
end

def update
		order = Order.find(params[:id])
		@order_details = order.order_details
    order.update(order_params)
    redirect_to admin_order_path(order.id)
end


private

def order_params
  params.require(:order).permit(:name, :address, :total_payment, :customer_id, :postal_code, :shipping_cost, :payment_method, :status, :created_at, :update_at)
end

end
