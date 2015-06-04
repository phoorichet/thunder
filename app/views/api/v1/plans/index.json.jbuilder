json.array!(@plans) do |plan|
  json.extract! plan, :id, :name, :plan_type, :begin_at, :end_at, :book_id
  json.url api_v1_book_plan_url(plan.book, plan, format: :json)
end
