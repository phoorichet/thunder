class Coverage < ActiveRecord::Base
	belongs_to :main_insurance
	belongs_to :rider
end
