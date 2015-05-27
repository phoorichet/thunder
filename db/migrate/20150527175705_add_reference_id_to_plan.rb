class AddReferenceIdToPlan < ActiveRecord::Migration
  def change
      add_column :plans, :reference_id, :integer
  end
end
