class CartItem < ApplicationRecord
  
  belongs_to :items
  belongs_to :customers
  
end
