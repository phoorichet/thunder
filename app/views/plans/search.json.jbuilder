json.array!(@plans) do |plan|
  json.extract! plan, 
  :id, 
  :name
end
