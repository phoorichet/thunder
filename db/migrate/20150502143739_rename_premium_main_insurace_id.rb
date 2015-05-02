class RenamePremiumMainInsuraceId < ActiveRecord::Migration
  def change
  	rename_column :premia, :main_insurace_id, :main_insurance_id
  end
end
