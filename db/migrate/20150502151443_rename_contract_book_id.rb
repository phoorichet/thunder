class RenameContractBookId < ActiveRecord::Migration
  def change
      rename_column :contracts, :book_id, :rider_id
  end
end
