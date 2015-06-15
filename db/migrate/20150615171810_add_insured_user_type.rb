class AddInsuredUserType < ActiveRecord::Migration
  def change
	  add_column :insured_users, :user_type, :string
  end
end
