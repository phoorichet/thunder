class AddPersonalAccidentPlanToContract < ActiveRecord::Migration
  def change
      add_column :contracts, :personal_accident_plan_id, :integer
  end
end
