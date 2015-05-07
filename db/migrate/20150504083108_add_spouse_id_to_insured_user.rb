class AddSpouseIdToInsuredUser < ActiveRecord::Migration
  def change
      add_column :insured_users, :spouse_id, :integer
  end
end
