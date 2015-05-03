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
	json.main_insurance contract.main_insurance

	json.riders contract.riders do |rider|
		json.extract! rider, :name, :begin_at, :end_at
	end
end
