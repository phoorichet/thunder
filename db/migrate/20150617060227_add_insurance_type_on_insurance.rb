class AddInsuranceTypeOnInsurance < ActiveRecord::Migration
  def change
	  add_column :insurances, :insurance_type, :string
  end
end
