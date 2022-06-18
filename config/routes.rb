Rails.application.routes.draw do
  root 'pages#home'
  resources :articles
  # only: [:show, :index, :new, :create, :edit, :update]. esto lo usamos cuando solo queremos mostrar algunas rutas, como quedo, muestra todas las posibles operaciones del backend.
  get 'signup', to: 'users#new'
  # post 'users', to: 'users#create'
  resources :users, except: [:new]
end
