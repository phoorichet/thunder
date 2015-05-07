class InsuredUser < ActiveRecord::Base
    # Tree enabled
    has_ancestry 

    has_many :addresses
    has_many :contracts

    # spouse getter and setter methods allow the user to record spouse, which
    # ancestry does not support.
    def spouse
    	if self.spouse_id == nil 
    		return nil
    	else
    		return InsuredUser.find_by(id: self.spouse_id)
    	end
    end

    def spouse=(insured_user)
    	self.spouse_id = insured_user.id
    end

end
