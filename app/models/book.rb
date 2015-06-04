class Book < ActiveRecord::Base
	belongs_to :insured_user
	has_many :plans, :dependent => :destroy

	validates :number, presence: true

	# main plan must contain only one element
	def main_plan
		self.plans.where(is_main: true).limit(1).first
	end

	def main_plans
		self.plans.where(is_main: true)
	end

	def not_main_plans
		self.plans.where(is_main: false)
	end

end
