class AddIndexOnIDs < ActiveRecord::Migration
  def change
	  add_index :persons, :user_id
	  add_index :persons, :spouse_id
	  add_index :books, :person_id
	  add_index :insurances, :book_id
	  add_index :riders, :insurance_id
	  add_index :returns, :insurance_id
	  add_index :surrenders, :insurance_id
	  add_index :protections, :insurance_id
	  add_index :dividends, :insurance_id
  end
end
