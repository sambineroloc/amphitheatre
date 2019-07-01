Rails.application.routes.draw do
  use_doorkeeper

  jsonapi_resources :blue_books
  jsonapi_resources :campaigns
  jsonapi_resources :chapters
  jsonapi_resources :characters
  jsonapi_resources :events
  jsonapi_resources :locations
  jsonapi_resources :setting_details
  jsonapi_resources :users, only: %i[show create update destroy]

  get '/me', to: 'sessions#me'
end
