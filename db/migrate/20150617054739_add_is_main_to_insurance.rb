class AddIsMainToInsurance < ActiveRecord::Migration
  def change
	  add_column :insurances, :is_main, :boolean
  end
end
