json.array!(@protections) do |protection|
  json.extract! protection, :id, :year, :age, :amount
  json.url insurance_protection_url(protection.insurance, protection, format: :json)
end
