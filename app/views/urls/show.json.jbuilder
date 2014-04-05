json.extract! @url, :id, :long, :short, :created_at, :updated_at
json.goto_url goto_url(@url.short)
