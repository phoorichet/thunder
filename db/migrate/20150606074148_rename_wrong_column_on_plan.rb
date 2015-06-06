class RenameWrongColumnOnPlan < ActiveRecord::Migration
  def change
      rename_column :plans, :paid_preriod_length, :paid_period_length
  end
end
