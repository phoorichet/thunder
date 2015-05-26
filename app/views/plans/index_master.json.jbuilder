json.array!(@plans) do |plan|
  json.extract! plan, 
  :id, 
  :name, 
  :plan_type, 
  :begin_at, 
  :end_at

  json.url plan_url(plan, format: :json)
end