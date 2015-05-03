class Contract < ActiveRecord::Base
	belongs_to :insured_user

	has_one :main_insurance
	has_many :riders
end
