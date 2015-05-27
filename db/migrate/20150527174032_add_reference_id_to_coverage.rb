class AddReferenceIdToCoverage < ActiveRecord::Migration
  def change
      add_column :coverages, :reference_id, :integer
  end
end
