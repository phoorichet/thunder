json.array!(@plans) do |plan|
  json.extract! plan, :id, :name, :plan_type, :begin_at, :end_at
  json.url api_v1_master_plan_url(plan, format: :json)
end
