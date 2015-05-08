json.extract! @insured_user, 
:id, 
:first_name, 
:last_name, 
:gender, 
:created_at, 
:updated_at

json.contracts @insured_user.contracts do |contract|
	json.begin_at contract.begin_at
	json.end_at contract.end_at
	json.insurance contract.insurance

	json.riders contract.riders do |rider|
		json.extract! rider, :name, :begin_at, :end_at
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
