json.array!(@riders) do |rider|
  json.extract! rider, 
  :id, 
  :name
end
