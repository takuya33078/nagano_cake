class Public::AddressesController < ApplicationController
 def index
  @address = Address.new
  @addresses = current_customer.addresses
 end
end
