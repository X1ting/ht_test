Rails.application.routes.draw do
  devise_for :users
  get 'persons/profile'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'home#index'
    #get 'persons/profile', as: 'user_root'

  namespace :api do
      namespace :v1 do
        post 'parser' => 'data#parser'
      end
    end
end
