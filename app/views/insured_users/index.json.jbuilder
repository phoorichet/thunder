json.array!(@insured_users) do |insured_user|
  json.extract! insured_user, :id, :first_name, :last_name, :gender
  json.url insured_user_url(insured_user, format: :json)
end
