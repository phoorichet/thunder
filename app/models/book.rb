class Book < ActiveRecord::Base
	belongs_to :insured_user
	has_many :plans, :dependent => :destroy

	validates :number, presence: true

	# main_plan return the plan associated with this book.
	# main plan must contain only one element.
	def main_plan
		self.plans.where(is_main: true).limit(1).first
	end

	# main_plans list all the main plans
	# it is used internally to find the existing main plans
	def main_plans
		self.plans.where(is_main: true)
	end

	# reverse of main_plan
	def not_main_plans
		self.plans.where(is_main: false)
	end

end
