class Public::OrdersController < ApplicationController
def index
 @orders = current_customer.orders
end

def show
 @order = Order.find(params[:id])
end

def new
 @addresses = current_customer.addresses
 @order = Order.new
end

def confirm
  @order = Order.new(order_params)
  @order.customer_id = current_customer.id
  if params[:order][:address_option] == "0"
    @order.name = current_customer.last_name + current_customer.first_name
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
  elsif params[:order][:address_option] == "1"
      shipment_address = Address.find(params[:order][:registered_address])
      @order.postal_code = shipment_address.postal_code
      @order.address = shipment_address.address
      @order.name = shipment_address.name
  elsif params[:order][:address_option] == "2"
      @address = Address.new()
      @address.address = params[:order][:address]
      @address.name = params[:order][:name]
      @address.postal_code = params[:order][:postal_code]
      @address.customer_id = current_customer.id
      if @address.save
      @order.postal_code = @address.postal_code
      @order.name = @address.name
      @order.address = @address.address
      else
       render 'new'
      end
  end
  @cart_items = current_customer.cart_items
  @total = 0
end

def create
  @order = Order.new(order_params)
  @order.save
  @cart_items = current_customer.cart_items
  @cart_items.each do |cart_item|
   @order_detail = OrderDetail.new
   @order_detail.order_id = @order.id
   @order_detail.item_id = cart_item.item_id
   @order_detail.price = cart_item.item.price
   @order_detail.amount = cart_item.amount
   @order_detail.save
  end
  @cart_items.destroy_all
  redirect_to public_orders_complete_path
end

private

def order_params
  params.require(:order).permit(:name, :address, :total_payment, :customer_id, :postal_code, :shipping_cost, :payment_method, :status, :created_at, :update_at)
end
end
