class AddedRiderToBook < ActiveRecord::Migration
  def change
	  add_column :riders, :book_id, :integer
  end
end
