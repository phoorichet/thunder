class AddMasterPlanIdToPlan < ActiveRecord::Migration
  def change
      add_column :plans, :master_plan_id, :integer
  end
end
