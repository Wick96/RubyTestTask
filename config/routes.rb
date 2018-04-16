Rails.application.routes.draw do
  resources :bookings do
    resources :attendances
    post :charge, to: "charges#create"
  end
  post 'webhooks' => 'charges#webhooks'
  get 'home/index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
end
