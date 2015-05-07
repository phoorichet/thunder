class AddCodeNameToMasterRider < ActiveRecord::Migration
  def change
      add_column :master_riders, :code_name, :string
  end
end
