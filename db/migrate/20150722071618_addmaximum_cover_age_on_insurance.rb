class AddmaximumCoverAgeOnInsurance < ActiveRecord::Migration
  def change
	  add_column :insurances, :maximum_cover_age, :integer
  end
end
