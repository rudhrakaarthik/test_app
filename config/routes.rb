Rails.application.routes.draw do
  get 'dashboard/index'
  post 'dashboard/show'
  root 'dashboard#index'
end
