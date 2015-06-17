class RemoveUnsedColumnOnCoverage < ActiveRecord::Migration
  def change
	  remove_column :coverages, :assured_amount
	  remove_column :coverages, :category
	  remove_column :coverages, :premium_amount
	  remove_column :coverages, :premium_unit
	  remove_column :coverages, :coverage_unit
	  remove_column :coverages, :coverage_end_at
	  add_column    :coverages, :value, :string
	  rename_column :coverages, :name, :key
  end
end
