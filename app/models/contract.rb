class Contract < ActiveRecord::Base
	belongs_to :insured_user
	belongs_to :main_insurance

	has_many :addons
	has_many :riders, through: :addons 
end
