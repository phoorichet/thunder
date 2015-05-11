json.array!(@contracts) do |contract|
  json.extract! contract, :id, :number, :begin_at, :end_at, :main_plan_id, :package_plan_id, :personal_accident_plan_id
  json.url contract_url(contract, format: :json)
end
