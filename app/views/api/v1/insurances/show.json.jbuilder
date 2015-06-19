json.extract! @insurance, 
:id, 
:name, 
:insurance_type,
:amount,
:premium,
:protection_length,
:paid_period_length,
:consider_year,
:consider_gender,
:company,
:minimum_age,
:maximum_age,
:group,
:created_at, 
:updated_at

json.riders @insurance.riders do |rider|
	json.name rider.name
	json.status rider.status
	json.code_name rider.code_name
	json.url api_v1_insurance_rider_url(rider.insurance, rider, format: :json)
end

json.dividends @insurance.dividends do |dividend|
	json.year dividend.year
	json.age dividend.age
	json.amount dividend.amount
	json.url api_v1_insurance_dividend_url(dividend.insurance, dividend, format: :json)
end
