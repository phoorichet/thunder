json.array!(@insurances) do |insurance|
  json.extract! insurance, :id, :name, :insurance_type, :begin_at, :end_at
  json.url api_v1_master_insurance_url(insurance, format: :json)
end
