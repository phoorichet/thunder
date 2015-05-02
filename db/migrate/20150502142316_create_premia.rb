class CreatePremia < ActiveRecord::Migration
  def change
    create_table :premia do |t|
      t.string :name
      t.string :description
      t.float :amount
      t.string :category
      t.integer :main_insurace_id
      t.integer :rider_id

      t.timestamps null: false
    end
  end
end
