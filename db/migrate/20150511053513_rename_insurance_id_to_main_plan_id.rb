class RenameInsuranceIdToMainPlanId < ActiveRecord::Migration
  def change
      rename_column :contracts, :insurance_id, :main_plan_id
  end
end
