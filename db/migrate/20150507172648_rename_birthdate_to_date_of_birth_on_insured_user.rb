class RenameBirthdateToDateOfBirthOnInsuredUser < ActiveRecord::Migration
  def change
      rename_column :insured_users, :birthdate, :date_of_birth
  end
end
