class AddCodeNameToRider < ActiveRecord::Migration
  def change
      add_column :riders, :code_name, :string
  end
end
