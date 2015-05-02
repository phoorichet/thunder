class Addon < ActiveRecord::Base
	belongs_to :rider
	belongs_to :contract
end
