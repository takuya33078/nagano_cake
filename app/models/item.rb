class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items
  has_many :order_details
  attachment :image
  validates :name, {presence: true}
  validates :introduction, {presence: true}
  validates :price, {presence: true}
  
  def with_tax_price
    (price * 1.1).floor
  end

end
