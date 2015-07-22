Rails.application.routes.draw do

  root 'indices#index'

  resources :indices do
  	resources :brands
  end

end
