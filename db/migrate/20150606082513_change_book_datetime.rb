class ChangeBookDatetime < ActiveRecord::Migration
  def up
      change_column :books, :begin_at, :date
      change_column :books, :end_at, :date
  end
  def down
      change_column :books, :begin_at, :datetime
      change_column :books, :end_at, :datetime
  end
end
