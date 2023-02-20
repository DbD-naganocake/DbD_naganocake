class CreateDeliveries < ActiveRecord::Migration[6.1]
  def change
    create_table :deliveries do |t|

      t.integer :customer_id,     null: false, default: ""
      t.string :name,              null: false, default: ""
      t.string :delivery_address,  null: false, default: ""
      t.string :delivery_post,     null: false, default: ""
      t.timestamps
    end
  end
end
