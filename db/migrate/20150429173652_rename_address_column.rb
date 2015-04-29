class RenameAddressColumn < ActiveRecord::Migration
  def change
      rename_column :addresses, :insure_user_id, :insured_user_id
  end
end
