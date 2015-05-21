class MasterCoverage < ActiveRecord::Base
	belongs_to :master_rider
	has_many :returns
end
