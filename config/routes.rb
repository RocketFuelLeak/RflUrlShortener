RflUrlShortener::Application.routes.draw do
  root 'urls#index'

  get '/' => 'urls#index', as: :urls
  get ':short' => 'urls#goto', constraints: { short: /[A-Za-z0-9]+/ }, as: :goto
  get ':id/details' => 'urls#show', as: :url

  post '/' => 'urls#create'
  post 'api/create' => 'urls#create', defaults: { format: 'json' }
end
