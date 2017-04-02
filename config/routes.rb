Rails.application.routes.draw do

  resources :groups, param: :slug, only: [:new, :create, :show, :edit, :update, :destroy], path: '/' do
    resources :users, only: [:new, :create]
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount ActionCable.server => '/cable'
end
