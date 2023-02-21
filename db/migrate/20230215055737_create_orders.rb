class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      
      t.integer :customer_id,    null: false, default: ""
      t.string :post_code,        null: false, default: ""
      t.string :address,          null: false, default: ""
      t.string :name,             null: false, default: ""
      t.integer :postage,         null: false, default: ""
      t.integer :total,           null: false, default: ""
      t.integer :payment_method,  null: false, default: "0"
      t.integer :order_status,    null: false, default: "0"
      t.timestamps
    end
  end
end
