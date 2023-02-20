class Delivery < ApplicationRecord

  belongs_to :customer

  validates :name, :delivery_address, :delivery_post, presence: true
end
