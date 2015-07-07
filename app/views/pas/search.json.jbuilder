json.array!(@pas) do |pa|
  json.extract! pa, 
  :id, 
  :name
end
