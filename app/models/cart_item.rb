class CartItem < ApplicationRecord
   validates :amount, presence: true
   belongs_to :customer
   belongs_to :item
   
   def subtotal
    item.with_tax_price * amount
   end

   def self.aggregate(column)
    self.all.map { |cart_item| cart_item.item[column] }.sum
   end
end
