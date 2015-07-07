class AddChildrenOnPerson < ActiveRecord::Migration
  def change
	  add_reference :persons, :parent, :index => true
  end
end
