class AddDefaultValueOnInsurance < ActiveRecord::Migration
  def up
	  change_column :insurances, :amount, :float, :default => 0.0
	  change_column :insurances, :premium, :float, :default => 0.0
  end

  def down
	  change_column :insurances, :amount, :float
	  change_column :insurances, :premium, :float
  end
end
