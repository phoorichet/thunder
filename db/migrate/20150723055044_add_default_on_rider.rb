class AddDefaultOnRider < ActiveRecord::Migration
  def change
	  change_column :riders, :amount, :float, dafult: 0.0
	  change_column :riders, :premium, :float, dafult: 0.0
	  add_index :riders, :book_id
  end
end
