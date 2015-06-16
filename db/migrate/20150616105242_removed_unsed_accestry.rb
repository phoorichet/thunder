class RemovedUnsedAccestry < ActiveRecord::Migration
  def change
	  remove_index  :persons, :accestry
	  remove_column :persons, :accestry
  end
end
