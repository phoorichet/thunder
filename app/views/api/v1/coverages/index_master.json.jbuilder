json.array!(@coverages) do |coverage|
  json.extract! coverage, 
  :id, 
  :name, 
  :value
  :description, 
  :tag_list

  json.url api_v1_master_coverage_url(coverage, format: :json)
end
