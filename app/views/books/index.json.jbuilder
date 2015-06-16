json.array!(@books) do |book|
  json.extract! book, :id, :number, :begin_at, :end_at, :assured_person_id, :payer_person_id
  json.url book_url(book, format: :json)
end
