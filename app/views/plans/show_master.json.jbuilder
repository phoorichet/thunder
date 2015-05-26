json.extract! @plan, 
:id, 
:name, 
:plan_type, 
:begin_at, 
:end_at, 
:book_id, 
:created_at, 
:updated_at

json.riders @plan.riders do |rider|
	json.extract! rider, 
	:id, 
	:name, 
	:description, 
	:status, 
	:code_name, 
	:created_at, 
	:updated_at

	json.url plan_rider_url(rider.plan, rider, format: :json)
end
