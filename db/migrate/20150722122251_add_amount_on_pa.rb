class AddAmountOnPa < ActiveRecord::Migration
  def change
	  add_column :pas, :amount, :float
	  add_column :pas, :maximum_cover_age, :integer
  end
end
