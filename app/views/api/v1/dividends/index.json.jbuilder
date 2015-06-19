json.array!(@dividends) do |dividend|
  json.extract! dividend, 
  :id, 
  :year, 
  :age, 
  :amount

  json.url insurance_dividend_url(dividend.insurance, dividend, format: :json)
end
