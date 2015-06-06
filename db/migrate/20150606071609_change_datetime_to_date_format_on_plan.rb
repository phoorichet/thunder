class ChangeDatetimeToDateFormatOnPlan < ActiveRecord::Migration
  def up
  	change_column :plans, :begin_at, :date
  	change_column :plans, :end_at, :date
  end

  def down
  	change_column :plans, :begin_at, :datetime
  	change_column :plans, :end_at, :datetime
  end
end
