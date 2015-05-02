class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.string :item_type
      t.float :premium_amount
      t.float :coverage_amount
      t.integer :rider_id
      t.integer :book_id

      t.timestamps null: false
    end
  end
end
