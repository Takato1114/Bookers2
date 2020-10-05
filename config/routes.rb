Rails.application.routes.draw do
  root 'top#index'
  get 'home/about' => "top#about"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show, :edit, :update]
  resources :books, only: [:create, :index, :show, :edit, :destroy, :update]

end
