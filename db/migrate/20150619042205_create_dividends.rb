class CreateDividends < ActiveRecord::Migration
  def change
    create_table :dividends do |t|
      t.integer :year
      t.integer :age
      t.float :dividend
      t.integer :insurance_id

      t.timestamps null: false
    end
  end
end
