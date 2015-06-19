json.array!(@returns) do |return|
  json.extract! return, :id, :year, :age, :amount
  json.url return_url(return, format: :json)
end
