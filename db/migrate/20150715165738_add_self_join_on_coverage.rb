class AddSelfJoinOnCoverage < ActiveRecord::Migration
  def change
	  add_reference :coverages, :coverage, index: true
  end
end
