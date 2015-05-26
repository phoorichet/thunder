json.extract! @rider, 
:id, 
:name, 
:description, 
:status, 
:code_name,
:updated_at,
:created_at

json.coverages @rider.coverages do |coverage|
	json.extract! coverage, 
	:id, 
	:name, 
	:description, 
	:assured_amount, 
	:category, 
	:rider_id, 
	:premium_amount, 
	:premium_unit, 
	:coverage_unit, 
	:coverage_end_at,
	:coverage_type,
	:tag_list

	json.url master_coverage_url(coverage, format: :json)
end