class Public::OrdersController < ApplicationController
def index
 @orders = Order.where(customer_id:current_customer)
end
  
def new
 @cart_items = current_customer.cart_items
end
end
