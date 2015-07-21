class Person < ActiveRecord::Base
    extend Enumerize
	# Tree enabled
    has_ancestry 

    # has_many :addresses, :dependent => :destroy
    has_many :books, :dependent => :destroy

    # self join
    # parent-children
    # has_many :children, class_name: "Person", foreign_key: "parent_id"
    # belongs_to :parent, class_name: "Person"
    # # sibling-sib
    # has_many :siblings, class_name: "Person", foreign_key: "sibling_id"
    # belongs_to :sib, class_name: "Person"
    # # spouse-partner
    has_one :spouse, class_name: "Person", foreign_key: "spouse_id"
    # belongs_to :partner, class_name: "Person"
    # employee-employer
    has_many :employees, class_name: "Person", foreign_key: "employer_id"
    belongs_to :employer, class_name: "Person"

    belongs_to :user


    # scopes
    scope :order_by_fist_name, -> { order(first_name: :asc)}
    scope :search_first_name, ->(value) { where("first_name ILIKE ?", "%#{value}%") if value != nil }
    scope :search_last_name, ->(value) { where("last_name ILIKE ?", "%#{value}%") if value != nil }

    # validations
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :date_of_birth, presence: true
    # validates :date_of_birth, format: { with: /\d{2}\/\d{2}\/\d{4}/, message: "Invalid date format. Must be dd/mm/yyyy e.g. 14/03/1985"}

    attr_accessor :relation_desc

    enumerize :relation_desc, in: [:parent, :spouse, :child, :sibling, :employer, :employee]

    def income_formatted
        self.income ? self.income.to_s(:currency, precision: 0) : "N/A"
    end

    def fullname
        "#{self.first_name} #{self.last_name}"
    end

    ############################ RELATION ######################################

    # Get all the parents that the person belongs to.
    def parents
        p = self.parent
        p == nil ? [] : [p, p.spouse].select {|d| d != nil}
    end

    # Return only the sibling excluded itself
    def get_siblings
        self.root? ? [] : self.siblings.select { |d| d.id != self.id }
    end

    def create_child(person)
        person.parent_id = self.id
        # child.save
    end

    def delete_child(person)
        person.parent_id = nil
    end

    def create_parent(person)
        self.parent_id = person.id
        self.save
    end

    def delete_parent(person)
        self.parent_id = nil
        self.save
    end

    def create_sibling(person)
        person.parent_id = self.parent_id
    end

    def delete_sibling(person)
        person.sibling_id = nil
    end

    def create_employee(person)
        person.employer_id = self.id
    end

    def delete_employee(person)
        person.employer = nil
    end

    def create_employer(person)
        self.employer_id = person.id
        self.save
    end

    def delete_employer(person)
        self.employer_id = nil
        self.save
    end

    def create_spouse(person)
        person.spouse_id = self.id
        self.spouse_id = person.id
        self.save
    end

    def delete_spouse(person)
        person.spouse_id = nil
        self.spouse_id = nil
        self.save
    end

    # Return all relations
    def relations
        relations = []
        # Parents
        self.parents.map {|d| d.relation_desc = 'parent'; d} .each {|d| relations << d}
        # self Children
        self.children.map {|d| d.relation_desc = 'child'; d} .each {|d| relations << d}
        
        # Children
        self.get_siblings.map {|d| d.relation_desc = 'sibling'; d} .each {|d| relations << d}
        # Employee
        self.employees.map {|d| d.relation_desc = 'employee'; d} .each {|d| relations << d}
        # Employer
        if self.employer != nil
            [self.employer].map {|d| d.relation_desc = 'employer'; d} .each {|d| relations << d}
        end
        # Spouse
        if self.spouse != nil
            [self.spouse].map {|d| d.relation_desc = 'spouse'; d} .each {|d| relations << d}
            # spouse children
            self.spouse.children.map {|d| d.relation_desc = 'child'; d} .each {|d| relations << d}
        end

        # Ancestor
        self.parents.each {|d| d.parents.map { |f| f.relation_desc = 'ancestor'; f  } .each {|g| relations << g}}
        
        relations
    end

    ############################ END RELATION ##################################

    # Shortcut to get all the riders that belong to person's books
    def riders
        result = []
        self.books.each do |book|
            book.plans.each do |plan|
                plan.riders.each do |rider|
                    result << rider
                end
            end
        end

        result
    end

    # return all the plan associatd with the user books
    def plans
        result = []
        self.books.each do |book|
            book.plans.each do |plan|
                result << plan
            end
        end

        result
    end

    def sum_insurance_premium
        # self.books.reduce(0) {|n, book| book.sum_insurance_premium + n}
    end
end
