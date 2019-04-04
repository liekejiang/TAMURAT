Rails.application.routes.draw do

  root   'static_pages#home'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/activate',to: 'activate#activate'
  resources :users
  
  #questions
  resources :questions
  #get '/questions/edit/:id', to: 'questions#edit', as: 'question_edit'
  
  #subcategory
  resources :subcategories
  #get '/subcategories/edit/:id', to: 'subcategories#edit', as: 'subcategory_edit'
  #category
  resources :categories
  #get '/categories/edit/:id', to: 'categories#edit', as: 'category_edit'

  resources :account_activations, only: [:edit]
end
