class Contract < ActiveRecord::Base
	belongs_to :insured_user
	belongs_to :main_plan
	belongs_to :package_plan
	belongs_to :personal_accident_plan
	
	has_many :riders
end
