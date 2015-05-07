class AddMoreColumnsToInsuredUser < ActiveRecord::Migration
  def change
      add_column :insured_users, :income, :float
      add_column :insured_users, :national_id, :string
      add_column :insured_users, :passport_id, :string
      add_column :insured_users, :height, :float
      add_column :insured_users, :weight, :float
      add_column :insured_users, :occupation, :string
  end
end
