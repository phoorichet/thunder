class AddMobileOnPerson < ActiveRecord::Migration
  def change
	  add_column :persons, :mobile, :string
  end
end
