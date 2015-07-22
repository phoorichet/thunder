class Rider < ActiveRecord::Base
	has_many :coverages, :dependent => :destroy
	# belongs_to :insurance
	belongs_to :book

	acts_as_taggable # Alias for acts_as_taggable_on :tags

	validates :name, presence: true

	scope :master, ->(){ where(rider_type: 'master')}

	def is_master?
		self.rider_type == 'master'
	end

	# copied_attributes copies only some attributes and return as a hash
	def copied_attributes
		attrs = {}
		attrs[:name] = self.name
		attrs[:description] = self.description
		attrs[:status] = self.status
		attrs[:code_name] = self.code_name
		attrs[:premium] = self.premium
		attrs[:amount] = self.amount
		attrs[:reference_id] = self.id
		attrs[:tag_list] = self.tag_list
		attrs[:maximum_cover_age] = self.maximum_cover_age

		attrs
	end
end
