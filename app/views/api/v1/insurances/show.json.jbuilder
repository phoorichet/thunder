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

json.returns @insurance.returns do |r|
	json.year r.year
	json.age r.age
	json.rate r.rate

	json.url api_v1_insurance_return_url(r.insurance, r, format: :json)
end

json.protections @insurance.protections do |protection|
	json.year protection.year
	json.age protection.age
	json.coverage_rate protection.coverage_rate

	json.url api_v1_insurance_protection_url(protection.insurance, protection, format: :json)
end

json.surrenders @insurance.surrenders do |surrender|
	json.surrender_type surrender.surrender_type
	json.year surrender.year
	json.assured_age surrender.assured_age
	json.cv surrender.cv
	json.rpu surrender.rpu
	json.ecv surrender.ecv
	json.eti surrender.eti
	json.eti_year surrender.eti_year
	json.eti_day surrender.eti_day

	json.url api_v1_insurance_surrender_url(surrender.insurance, surrender, format: :json)
end

json.dividends @insurance.dividends do |dividend|
	json.year dividend.year
	json.age dividend.age
	json.amount dividend.amount

	json.url api_v1_insurance_dividend_url(dividend.insurance, dividend, format: :json)
end
