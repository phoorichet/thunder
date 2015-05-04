class ChangePremiumColumns < ActiveRecord::Migration
  def change
      add_column :premiums, :master_rider_id, :integer
      add_column :premiums, :master_insurace_id, :integer
      add_column :premiums, :insurance_id, :integer
      remove_column :premiums, :main_insurance_id, :integer
  end
end
