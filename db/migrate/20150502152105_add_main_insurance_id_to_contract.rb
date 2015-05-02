class AddMainInsuranceIdToContract < ActiveRecord::Migration
  def change
      add_column :contracts, :main_insurance_id, :integer
  end
end
