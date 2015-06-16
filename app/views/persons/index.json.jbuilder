json.array!(@persons) do |person|
  json.extract! person, :id, :first_name, :last_name, :gender, :date_of_birth, :marital_status, :spouse_id, :income, :national_id, :passport_id, :height, :weight, :occupation, :person_type, :is_smoking
  json.url person_url(person, format: :json)
end
