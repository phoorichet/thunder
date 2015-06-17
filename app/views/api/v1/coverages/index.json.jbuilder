json.array!(@coverages) do |coverage|
  json.extract! coverage, 
  :id, 
  :name, 
  :value
  :description, 
  :tag_list

  json.url api_v1_rider_coverage_url(coverage.rider, coverage, format: :json)
end
