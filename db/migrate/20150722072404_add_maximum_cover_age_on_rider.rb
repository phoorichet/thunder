class AddMaximumCoverAgeOnRider < ActiveRecord::Migration
  def change
	  add_column :riders, :maximum_cover_age, :integer
  end
end
