class Book < ActiveRecord::Base
	belongs_to :person
	has_many :insurances, :dependent => :destroy
	has_many :riders, :dependent => :destroy
	has_many :pas, :dependent => :destroy

	belongs_to :assured_person, class_name: "Person", foreign_key: "assured_person_id"
	belongs_to :payer_person, class_name: "Person", foreign_key: "payer_person_id"

	default_scope { order(created_at: 'ASC') }

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

	def begin_age
		delta = (self.begin_at - self.person.date_of_birth) / 365
		delta.to_i
	end

	def end_age
		return nil if self.end_at == nil

		delta = (self.end_at - self.person.date_of_birth) / 365
		delta.to_i
	end

	def sum_insurance_premium
		self.insurances.inject(0) { |sum, i|  sum + i.premium }
	end

end
