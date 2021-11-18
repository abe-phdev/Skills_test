Rails.application.routes.draw do
  root to: "sorts#index"
  resources :sorts
end
