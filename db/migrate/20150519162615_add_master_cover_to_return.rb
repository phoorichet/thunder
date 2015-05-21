class AddMasterCoverToReturn < ActiveRecord::Migration
  def change
      add_column :returns, :master_coverage_id, :integer
  end
end
