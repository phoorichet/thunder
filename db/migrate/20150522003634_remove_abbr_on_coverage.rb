class RemoveAbbrOnCoverage < ActiveRecord::Migration
  def change
      remove_column :coverages, :abbr
  end
end
