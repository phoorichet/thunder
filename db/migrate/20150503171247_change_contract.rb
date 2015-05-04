class ChangeContract < ActiveRecord::Migration
  def change
      remove_column :contracts, :rider_id
      rename_column :contracts, :main_insurance_id, :insurance_id
  end
end
