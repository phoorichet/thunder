json.array!(@persons) do |persons|
  json.extract! persons, 
  :id, 
  :first_name,
  :last_name
end
