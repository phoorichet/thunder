class RenameMasterRiderIdToReferenceId < ActiveRecord::Migration
  def change
      rename_column :riders, :master_rider_id, :reference_id
  end
end
