class RenameContractIdToBookIdOnRider < ActiveRecord::Migration
  def change
      rename_column :riders, :contract_id, :book_id
  end
end
