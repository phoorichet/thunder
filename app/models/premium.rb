class Premium < ActiveRecord::Base
	belongs_to :rider
	belongs_to :master_rider
	belongs_to :insurance
	belongs_to :master_insurance
end
