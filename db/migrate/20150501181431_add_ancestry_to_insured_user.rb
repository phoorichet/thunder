class AddAncestryToInsuredUser < ActiveRecord::Migration
  def change
    add_column :insured_users, :ancestry, :string
    add_index :insured_users, :ancestry
  end
end
