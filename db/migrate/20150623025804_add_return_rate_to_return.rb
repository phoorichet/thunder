class AddReturnRateToReturn < ActiveRecord::Migration
  def change
	  add_column :returns, :rate, :float
  end
end
