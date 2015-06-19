json.extract! @book, :id, :number, :begin_at, :end_at, :created_at, :updated_at

json.insurances @book.insurances do |insurance|
	json.extract! insurance, :id, :name
	json.url api_v1_book_insurance_url(insurance.book, insurance, format: :json)
end
