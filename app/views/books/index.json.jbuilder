json.array!(@books) do |book|
  json.extract! book, :id, :number, :begin_at, :end_at
  json.url book_url(book, format: :json)
end
