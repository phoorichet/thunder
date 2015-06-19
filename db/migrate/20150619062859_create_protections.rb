class CreateProtections < ActiveRecord::Migration
  def change
    create_table :protections do |t|
      t.integer :year
      t.integer :age
      t.float :amount
	  t.integer :insurance_id

      t.timestamps null: false
    end
  end
end
