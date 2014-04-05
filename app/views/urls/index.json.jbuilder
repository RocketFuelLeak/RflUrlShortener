json.array!(@urls) do |url|
  json.extract! url, :id, :long, :short
  json.url url_url(url, format: :json)
end
