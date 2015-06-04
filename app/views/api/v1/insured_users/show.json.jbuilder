json.extract! @insured_user, 
:id, 
:first_name, 
:last_name, 
:gender, 
:date_of_birth,
:marital_status,
:income,
:national_id,
:passport_id,
:height,
:weight,
:occupation,
:created_at, 
:updated_at

json.riders do |rider|
	json.name rider.name
end

json.books @insured_user.books do |book|
	json.begin_at book.begin_at
	json.end_at book.end_at

	json.plan book.plans do |plan|
		json.extract! plan, :name, :begin_at, :end_at
	end
end

json.parents @insured_user.parents do |parent|
	json.first_name parent.first_name
	json.last_name parent.last_name
end

if @insured_user.spouse != nil
	json.spouse do 
		json.first_name @insured_user.spouse.first_name
		json.last_name @insured_user.spouse.last_name
	end
end

if not @insured_user.root?
	json.relatives @insured_user.siblings do |sibling|
		json.first_name sibling.first_name
		json.last_name sibling.last_name
	end
end

json.children @insured_user.children do |child|
	json.first_name child.first_name
	json.last_name child.last_name
end
