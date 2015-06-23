json.array!(@protections) do |protection|
  json.extract! protection, :id, :year, :age, :amount, :coverage_rate
  json.url insurance_protection_url(protection.insurance, protection, format: :json)
end
