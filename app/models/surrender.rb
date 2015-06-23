class Surrender < ActiveRecord::Base
	belongs_to :insurance

	validates :surrender_type, inclusion: { in: %w(CV RPU ETI), message: "%{value} is not a valid surrender type" }

	def self.selectable_types
		[['CV', 'CV'], ['RPU', 'RPU'], ['ETI', 'ETI']]
	end
end
