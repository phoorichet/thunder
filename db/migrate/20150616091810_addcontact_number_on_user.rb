class AddcontactNumberOnUser < ActiveRecord::Migration
  def change
	  add_column :users, :contact_number, :string
	  add_column :users, :job_title, :string
	  add_column :users, :job_unit, :string
	  add_column :users, :address, :text
	  add_column :users, :billing_address, :text
  end
end
