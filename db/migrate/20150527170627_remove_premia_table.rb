class RemovePremiaTable < ActiveRecord::Migration
  def change
      drop_table :premia
  end
end
