Rails.application.routes.draw do
  use_doorkeeper
  mount_ember_app :stage, to: "/"

  jsonapi_resources :blue_books
  jsonapi_resources :campaigns
  jsonapi_resources :chapters
  jsonapi_resources :characters
  jsonapi_resources :setting_details
  jsonapi_resources :users, only: %i[show create update destroy]
end
