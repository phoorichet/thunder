class ChangeAncestryColumn < ActiveRecord::Migration
  def change
	  add_column :persons, :ancestry, :string
	  add_index :persons, :ancestry
	  # remove_column :persons, :accestry
	  # remove_index :persons, :accestry
  end
end
