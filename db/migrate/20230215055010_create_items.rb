class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      
      t.integer :genre_id,          null: false, default: ""
      t.string :item_name,          null: false, default: ""
      t.text :item_caption,         null: false, default: ""
      t.integer :without_tax,       null: false, default: ""
      t.boolean :sale_status,       null: false, default: "true"
      
      t.timestamps
    end
  end
end
