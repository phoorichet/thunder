json.extract! @book, :id, :number, :begin_at, :end_at, :created_at, :updated_at

json.plans @book.plans do |plan|
	json.extract! plan, :id, :name
	json.url api_v1_book_plan_url(plan.book, plan, format: :json)
end
