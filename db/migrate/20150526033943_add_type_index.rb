class AddTypeIndex < ActiveRecord::Migration
  def change
      add_index :coverages, :coverage_type
      add_index :riders, :rider_type
      add_index :plans, :plan_type
  end
end
