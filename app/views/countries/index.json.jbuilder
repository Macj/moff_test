json.array!(@countries) do |country|
  json.extract! country, :name, :vesited
  json.url country_url(country, format: :json)
end
