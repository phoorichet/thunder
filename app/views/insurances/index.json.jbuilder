json.array!(@insurances) do |insurance|
  json.extract! insurance, :id, :name, :amount, :premium, :protection_length, :paid_period_length, :consider_year, :consider_gender, :company, :reference_id, :book_id
  json.url insurance_url(insurance, format: :json)
end
