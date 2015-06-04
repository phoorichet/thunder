class Book < ActiveRecord::Base
	belongs_to :insured_user
	has_many :plans, :dependent => :destroy

	validates :number, presence: true
end
