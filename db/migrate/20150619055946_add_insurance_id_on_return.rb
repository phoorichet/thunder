class AddInsuranceIdOnReturn < ActiveRecord::Migration
  def change
	  add_column :returns, :insurance_id, :integer
  end
end
