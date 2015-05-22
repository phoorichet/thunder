json.array!(@coverages) do |coverage|
  json.extract! coverage, :id, :name, :description, :assured_amount, :category, :rider_id, :master_rider_id, :premium_amount, :premium_unit, :coverage_unit, :coverage_end_at
  json.url coverage_url(coverage, format: :json)
end
