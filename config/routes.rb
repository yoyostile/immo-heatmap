Rails.application.routes.draw do

  resources :apartments
  get 'crawl', to: 'apartments#crawl'

  root 'apartments#index'
end
