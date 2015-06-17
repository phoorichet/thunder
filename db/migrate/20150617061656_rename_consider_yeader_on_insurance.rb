class RenameConsiderYeaderOnInsurance < ActiveRecord::Migration
  def change
	  rename_column :insurances, :consider_yeader, :consider_year
  end
end
