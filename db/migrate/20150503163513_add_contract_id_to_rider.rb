class AddContractIdToRider < ActiveRecord::Migration
  def change
      add_column :riders, :contract_id, :integer
      add_column :riders, :master_rider_id, :integer
  end
end
