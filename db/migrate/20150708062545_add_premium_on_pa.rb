class AddPremiumOnPa < ActiveRecord::Migration
  def change
	  add_column :pas, :premium, :float
  end
end
