class RenameBookIdToPlanIdOnRider < ActiveRecord::Migration
  def change
      rename_column :riders, :book_id, :plan_id
  end
end
