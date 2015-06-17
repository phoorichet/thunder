class AddColumnsOnInsurance < ActiveRecord::Migration
  def change
	  add_column :insurances, :minimum_age, :integer
	  add_column :insurances, :maximum_age, :integer
	  add_column :insurances, :group, :string
  end
end
