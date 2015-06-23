class AddProtectionCoverageRate < ActiveRecord::Migration
  def change
	  add_column :protections, :coverage_rate, :float
  end
end
