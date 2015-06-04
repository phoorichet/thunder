json.array!(@riders) do |rider|
  json.extract! rider, :id, :name, :description, :status, :code_name
  json.url api_v1_plan_rider_url(rider.plan, rider, format: :json)
end
