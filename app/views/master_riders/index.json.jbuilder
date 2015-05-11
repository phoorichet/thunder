json.array!(@master_riders) do |master_rider|
  json.extract! master_rider, :id, :name, :begin_at, :end_at, :description, :status, :code_name
  json.url master_rider_url(master_rider, format: :json)
end
