class AddColumnContract < ActiveRecord::Migration
  def change
      add_column :contracts, :number, :string
  end
end
