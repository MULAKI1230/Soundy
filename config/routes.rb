Rails.application.routes.draw do
  resources :artists
  resources :albums
  resources :tracks
  resources :playlists do
    member do
      get 'add_tracks', to: 'playlists#add_tracks'
      post 'add_track/:track_id', to: 'playlists#add_track', as: 'add_track'
      delete 'remove_track/:track_id', to: 'playlists#remove_track', as: 'remove_track'
    end
  end

  root "tracks#index"
end