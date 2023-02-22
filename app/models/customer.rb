class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items
  has_many :orders
  has_many :deliveries

  with_options presence: true do
    validates :last_name
    validates :first_name
    validates :kana_last
    validates :kana_first
    validates :post_code
    validates :address
    validates :telephone
    validates :email
  end


end
# customer（会員）はたくさんのcart_item(注文商品),orders(注文),deliveries(配送先)を持っている
# dependent: :destroy（親モデルを削除する際に、その親モデルに紐づく「子モデル」も一緒に削除できる）は必要？