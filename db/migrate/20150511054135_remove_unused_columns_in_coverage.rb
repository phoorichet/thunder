class RemoveUnusedColumnsInCoverage < ActiveRecord::Migration
  def change
      remove_column :coverages, :master_rider_id
      remove_column :coverages, :master_insurace_id
      remove_column :coverages, :insurance_id
  end
end
