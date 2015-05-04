class ChangeCoverageColumns < ActiveRecord::Migration
  def change
      add_column :coverages, :master_rider_id, :integer
      add_column :coverages, :master_insurace_id, :integer
      add_column :coverages, :insurance_id, :integer
      remove_column :coverages, :main_insurance_id, :integer
  end
end
