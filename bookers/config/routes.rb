Rails.application.routes.draw do

  get '/' => 'home#top'

  root 'home#top'

  get 'home/about' => 'home#about'

  devise_for :users

  #root 'books#index'

  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update]

  resources :users, only: [:show, :edit, :index, :update]

end
