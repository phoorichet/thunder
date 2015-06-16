class RenameInsuredUserToPerson < ActiveRecord::Migration
  def change
	  rename_column :books, :insured_user_id, :person_id
  end
end
