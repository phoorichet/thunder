class AddCompanyOnUser < ActiveRecord::Migration
  def change
	  add_column :persons, :company, :string
  end
end
