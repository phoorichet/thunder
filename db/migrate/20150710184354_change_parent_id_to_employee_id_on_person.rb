class ChangeParentIdToEmployeeIdOnPerson < ActiveRecord::Migration
  def change
	  rename_column :persons, :parent_id, :employer_id
	  # rename_column :persons, :spouse_id, :partner_id
  end
end
