class Book < ActiveRecord::Base
	belongs_to :person
	has_many :insurances, :dependent => :destroy
	has_many :riders, :dependent => :destroy
	has_many :pas, :dependent => :destroy

	belongs_to :assured_person, class_name: "Person", foreign_key: "assured_person_id"
	belongs_to :payer_person, class_name: "Person", foreign_key: "payer_person_id"

	validates :number, presence: true

	# main_insurance return the insurance associated with this book.
	# main insurance must contain only one element.
	def main_insurance
		self.insurances.main.limit(1).first
	end

	# main_insurances list all the main insurances
	# it is used internally to find the existing main insurances
	def main_insurances
		self.insurances.where(is_main: true)
	end

	# reverse of main_insurance
	def rider_insurances
		self.insurances.rider
	end

	# check if the book has main insurance
	def has_main_insurance?
		self.insurances.main.limit(1).first != nil
	end

end
