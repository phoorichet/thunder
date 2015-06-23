json.array!(@surrenders) do |surrender|
  json.extract! surrender, :id, :surrender_type, :year, :assured_age, :cv, :rpu, :ecv, :eti, :eti_year, :eti_day, :etipe
  json.url surrender_url(surrender, format: :json)
end
