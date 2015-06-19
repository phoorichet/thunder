json.array!(@coverages) do |coverage|
  json.extract! coverage, 
  :id, 
  :key
end
