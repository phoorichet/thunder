class RenameMainRiderIdOnBooks < ActiveRecord::Migration
  def change
      rename_column :books, :main_rider_id, :main_plan_id
  end
end
