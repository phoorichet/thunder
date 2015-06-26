json.extract! @rider, 
:id, 
:name, 
:description, 
:status, 
:code_name, 
:premium, 
:amount, 
:created_at, 
:updated_at

json.coverages @rider.coverages do |coverage|
		json.id coverage.id
		json.name coverage.name
		json.tag_list coverage.tag_list
		json.url api_v1_rider_coverage_url(coverage.rider, coverage, format: :json)
end