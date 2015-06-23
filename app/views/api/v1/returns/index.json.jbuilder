json.array!(@returns) do |return|
  json.extract! return, :id, :year, :age, :amount, :rate
  
  json.url insurance_return_url(return.insurance, return, format: :json)
end
