json.array!(@insurances) do |insurance|
  json.extract! insurance, 
  :id, 
  :name
end
