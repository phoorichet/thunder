class InsuredUser < ActiveRecord::Base
    # Tree enabled
    has_ancestry 

    has_many :addresses
    has_many :contracts

    # scopes
    scope :order_by_fist_name, -> { order(first_name: :asc)}

    # validations
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :date_of_birth, presence: true
    # validates :date_of_birth, format: { with: /\d{2}\/\d{2}\/\d{4}/, message: "Invalid date format. Must be dd/mm/yyyy e.g. 14/03/1985"}

    # spouse getter and setter methods allow the user to record spouse, which
    # ancestry does not support.
    def spouse
    	if self.spouse_id == nil 
    		return nil
    	else
    		return InsuredUser.find_by(id: self.spouse_id)
    	end
    end

    # Make it two set
    def spouse=(insured_user)
    	self.spouse_id = insured_user.id
        insured_user.spouse_id = self.spouse_id
    end

    def income_formatted
        if self.income
            self.income.to_s(:currency, precision: 0)
        else
            "N/A"
        end
    end

    def parents
        if self.parent == nil
            [] 
        else
            parents = [self.parent]
            parents << self.parent.spouse if self.parent.spouse
            parents
        end
    end

    # Return only the sibling excluded itself
    def get_siblings
        self.root? ? [] : self.siblings.select { |d| d.id != self.id }
    end

end
