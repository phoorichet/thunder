class AddPackagePlangIdToContract < ActiveRecord::Migration
  def change
      add_column :contracts, :package_plan_id, :integer
  end
end
