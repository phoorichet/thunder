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
    enumerize :gender, in: [:male, :female]

    ############################ PROPERTIES ####################################

    def income_formatted
        self.income ? self.income.to_s(:currency, precision: 0) : "N/A"
    end

    def fullname
        "#{self.first_name} #{self.last_name}"
    end

    def current_age
        delta = (Date.current - self.date_of_birth) / 365
        delta.to_i
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

    def relation_groups
        self.relations.group_by {|d| d.relation_desc}
    end

    ############################ END RELATION ##################################



    def pas
        result = []
        self.books.each do |book|
            book.pas.each do |pa|
                result << pa
            end
        end

        result
    end

    def sum_insurance_premium
        self.books.inject(0) { |sum, i|  sum + i.sum_insurance_premium }
    end

    def sum_insurance_amount
        self.books.inject(0) { |sum, i|  sum + i.sum_insurance_amount }
    end

    def sum_rider_premium
       self.books.inject(0) { |sum, i|  sum + i.sum_rider_premium } 
    end

    def sum_rider_amount
        self.books.inject(0) { |sum, i|  sum + i.sum_rider_amount } 
    end

    def insurances
        self.books.map { |b| b.main_insurance } .select {|d| d != nil}
    end

    def riders
        riders = []
        self.books.each do |b|
            b.riders.each {|r| riders << r if r != nil}
        end
        riders
    end

    def find_rider(rider_id)
        r = riders.select {|d| d.id == rider_id} 
        r.size > 0 ? r.first : nil
    end

    def coverages_tagged_with(tags)
        result = []
        self.books.each do |book|
            book.riders.each do |rider|
                rider.coverages.tagged_with(tags).each do |coverage|
                    result << coverage 
                end
            end
        end
        result
    end

    def coverages_tagged_with_life
        coverages_tagged_with(["ความคุ้มครองและผลประโยชน์ที่ได้รับด้านชีวิต"])
    end

    def coverages_tagged_with_in_patient
        coverages_tagged_with(["ค่ารักษาพยาบาลผู้ป่วยใน"])
    end

    def coverages_tagged_with_out_patient
        coverages_tagged_with(["ค่ารักษาพยาบาลผู้ป่วยนอก"])
    end

    def coverages_tagged_with_medicine_in_patient
        coverages_tagged_with(["ค่ายากลับบ้านต่อการรักษาเป็นผู้ป่วยใน"])
    end

    def coverages_tagged_with_cancer_disease
        coverages_tagged_with(["ค่ารักษาโรคมะเร็งหรือโรคร้ายต่อเนื่อง"])
    end

    def coverages_tagged_with_payback_in_hospital
        coverages_tagged_with(["ค่าชดเชยระหว่างการรักษาตัวในรพ"])
    end

    def coverages_tagged_with_accident
        coverages_tagged_with(["ชดเชยเนื่องจากอุบัติเหตุ"])
    end
end
