class Protection < ActiveRecord::Base
	belongs_to :insurance
	
	# copied_attributes copies only some attributes and return as a hash
	def copied_attributes
		attrs = {}
		attrs[:year] = self.year
		attrs[:age] = self.age
		attrs[:amount] = self.amount
		attrs[:coverage_rate] = self.coverage_rate

		attrs
	end
end
