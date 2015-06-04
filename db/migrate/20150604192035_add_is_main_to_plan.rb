class AddIsMainToPlan < ActiveRecord::Migration
  def change
      add_column :plans, :is_main, :boolean, :default => false
  end
end
