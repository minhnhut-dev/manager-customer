Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  resources :customers do
    collection do
      post 'import_customer', to: 'customers#import_customer'
    end
  end
  resources :notifications do
    collection do
      post 'send_sms', to: 'notifications#send_sms'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
