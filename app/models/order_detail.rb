class OrderDetail < ApplicationRecord
  
  belongs_to :order
  belongs_to :item
  
  enum production_status: {cannot_start:0, waiting_start:1, in_production:2, finish:3}

  
  
end
