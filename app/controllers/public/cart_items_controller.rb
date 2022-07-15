class Public::CartItemsController < ApplicationController
 def index
  @cart_items = current_customer.cart_items
  @total_price = calculate(current_customer)
 end

 def create
   if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
    cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    cart_item.amount += params[:cart_item][:amount].to_i
    cart_item.save
   	flash[:notice] = "Item was successfully added to cart."
   	redirect_to public_cart_items_path
   else
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.save
   	flash[:notice] = "New Item was successfully added to cart."
   	redirect_to public_cart_items_path
   end
 end

 def update
  cart_item = CartItem.find(params[:id])
  cart_item.update(cart_item_params)
  redirect_to public_cart_items_path
 end

 def destroy
  cart_item = CartItem.find(params[:id])
  cart_item.destroy
  redirect_to public_cart_items_path
 end

 def destroy_all
  current_customer.cart_items.destroy_all
  redirect_to public_cart_items_path
 end

  private
 def cart_item_params
  params.require(:cart_item).permit(:amount, :item_id, :customer_id)
 end
 def calculate(customer)
   total_price = 0
   customer.cart_items.each do |cart_item|
     total_price += cart_item.amount * cart_item.item.price
   end
   return (total_price * 1.1).floor
 end
end
