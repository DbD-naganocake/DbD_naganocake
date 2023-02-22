class Delivery < ApplicationRecord

  belongs_to :customer

  def address_display
  '〒' + delivery_post + ' ' + delivery_address + ' ' + name
  end

  validates :name, :delivery_address, :delivery_post, presence: true
end
