json.array!(@master_coverages) do |master_coverage|
  json.extract! master_coverage, :id, :name, :description, :coverage_amount, :category, :master_rider_id, :abbr, :premium_amount, :premium_unit, :coverage_unit, :coverage_end_at
  json.url master_coverage_url(master_coverage, format: :json)
end
