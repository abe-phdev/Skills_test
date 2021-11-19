Rails.application.routes.draw do
  root to: "sorts#new"
  resources :sorts
end
