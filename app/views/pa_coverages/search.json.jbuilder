json.array!(@pa_coverages) do |pa_coverage|
  json.extract! pa_coverage, 
  :id, 
  :key
end
