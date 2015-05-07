json.array!(@riders) do |rider|
  json.extract! rider, :id, :name, :description, :status, :code_name
  json.url rider_url(rider, format: :json)
end
