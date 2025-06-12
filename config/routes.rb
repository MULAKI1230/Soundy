Rails.application.routes.draw do
  resources :artists
  resources :albums
  resources :tracks
  resources :playlists
  
  get '/index' => 'tracks#index'
end
