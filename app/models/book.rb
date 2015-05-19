class Book < ActiveRecord::Base
	belongs_to :insured_user
	has_many :riders
end
