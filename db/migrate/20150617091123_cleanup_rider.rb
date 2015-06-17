class CleanupRider < ActiveRecord::Migration
  def change
	  rename_column :riders, :plan_id, :insurance_id
	  remove_column :riders, :number
  end
end
