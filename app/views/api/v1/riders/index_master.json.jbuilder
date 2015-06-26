json.array!(@riders) do |rider|
  json.extract! rider, :id, :name, :description, :status, :code_name, :premium, :amount

  json.url api_v1_master_rider_url(rider, format: :json)
end
