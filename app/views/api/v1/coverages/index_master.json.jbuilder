json.array!(@coverages) do |coverage|
  json.extract! coverage, 
  :id, 
  :key, 
  :value,
  :description, 
  :tag_list

  json.url api_v1_master_coverage_url(coverage, format: :json)
end
