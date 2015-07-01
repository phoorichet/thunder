json.array!(@riders) do |rider|
  json.extract! rider, :id, :name, :description, :status, :code_name, :premium, :amount
  json.url api_v1_book_rider_url(rider.book, rider, format: :json)
end
