Rails.application.routes.draw do
  get 'shift_preferences/new'
  root   "static_pages#home"
  get    "/help",    to: "static_pages#help"
  get    "/about",   to: "static_pages#about"
  get    "/contact", to: "static_pages#contact"
  get    "/signup",  to: "users#new"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"

  resources :users
  resources :tasks,  except: %i[show]

  #以下、otsutome.

  get "/calendar/admin", to: "static_pages#admincalendar"
  get "/calendar/:user_id", to: "static_pages#calendar", as: 'calendar'


  resources :shifts,   except: %i[show]
  get '/shifts', to: 'static_pages#home'


  resources :shift_preferences, only: [:new, :create, :edit, :update, :destroy, :index]


end

