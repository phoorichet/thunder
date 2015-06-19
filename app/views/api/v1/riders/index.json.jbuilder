json.array!(@riders) do |rider|
  json.extract! rider, :id, :name, :description, :status, :code_name
  json.url api_v1_insurance_rider_url(rider.insurance, rider, format: :json)
end
