json.array!(@coverages) do |coverage|
  json.extract! coverage, :id, :name, :description, :coverage_amount, :category, :rider_id, :master_rider_id, :abbr, :premium_amount, :premium_unit, :coverage_unit, :coverage_end_at
  json.url coverage_url(coverage, format: :json)
end
