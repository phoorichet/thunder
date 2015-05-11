class Rider < ActiveRecord::Base
	has_many :coverages
	belongs_to :contract

	scope :master, ->(){ where(rider_type: 'master')}
end
