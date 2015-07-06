class Surrender < ActiveRecord::Base
	belongs_to :insurance

	validates :surrender_type, inclusion: { in: %w(CV RPU ETI), message: "%{value} is not a valid surrender type" }

	def self.selectable_types
		[['CV', 'CV'], ['RPU', 'RPU'], ['ETI', 'ETI']]
	end

	# copied_attributes copies only some attributes and return as a hash
	def copied_attributes
		attrs = {}
		attrs[:surrender_type] = self.surrender_type
		attrs[:year] = self.year
		attrs[:assured_age] = self.assured_age
		attrs[:rpu] = self.rpu
		attrs[:ecv] = self.ecv
		attrs[:eti] = self.eti
		attrs[:eti_year] = self.eti_year
		attrs[:eti_day] = self.eti_day
		attrs[:etipe] = self.etipe

		attrs
	end
end
