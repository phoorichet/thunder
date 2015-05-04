class Contract < ActiveRecord::Base
	belongs_to :insured_user

	belongs_to :insurance
	has_many :riders
end
