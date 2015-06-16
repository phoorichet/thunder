class AddPayerAssuedToBook < ActiveRecord::Migration
  def change
	  add_column :books, :assured_person_id, :integer
	  add_column :books, :payer_person_id, :integer
  end
end
