json.extract! @plan, 
:id, 
:name, 
:plan_type, 
:begin_at, 
:end_at, 
:created_at, 
:updated_at

json.riders @plan.riders do |rider|
	json.name rider.name
	json.status rider.status
	json.code_name rider.code_name
	json.url api_v1_master_rider_url(rider, format: :json)
end
