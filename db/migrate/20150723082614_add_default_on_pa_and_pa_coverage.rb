class AddDefaultOnPaAndPaCoverage < ActiveRecord::Migration
  def change
	  change_column :pas, :premium, :float, default: 0.0
	  change_column :pas, :amount, :float, default: 0.0
  end
end
