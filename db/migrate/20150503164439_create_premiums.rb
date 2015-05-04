class CreatePremiums < ActiveRecord::Migration
  def change
    create_table :premiums do |t|
      t.string :name
      t.string :description
      t.float :amount
      t.integer :rider_id
      t.integer :main_insurance_id

      t.timestamps null: false
    end
  end
end
