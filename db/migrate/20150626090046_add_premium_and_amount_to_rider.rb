class AddPremiumAndAmountToRider < ActiveRecord::Migration
  def change
	  add_column :riders, :premium, :float
	  add_column :riders, :amount, :float
  end
end
