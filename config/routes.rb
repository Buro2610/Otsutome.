Rails.application.routes.draw do
  root   "static_pages#home"
  get    "/help",    to: "static_pages#help"
  get    "/about",   to: "static_pages#about"
  get    "/contact", to: "static_pages#contact"
  get    "/signup",  to: "users#new"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"

  resources :users do
    resources :shifts,except: [:show]
  end
  resources :tasks,except: %i[show] do
    put :update_order, on: :collection  # changed from :member to :collection
  end

  #以下、otsutome.

  get "/calendar/admin", to: "shifts#admincalendar"

  get '/shifts', to: 'static_pages#home'


  resources :preference_levels, only: [:create, :update, :destroy, :edit] do
    put :update_order, on: :collection  # changed from :member to :collection
  end

  resources :time_slots, only: [:create, :update, :destroy, :edit] do
    put :update_order, on: :collection  # changed from :member to :collection
  end


  get 'shift_preferences/new'
  get "/shift_preferences/admin", to: "shift_preferences#adminindex"
  get "/shift_preferences/shift", to: "shift_preferences#adminshift"

  resources :shift_preferences, only: [:new, :create, :destroy, :index] do
    collection do
      get :datatable
    end
  end


end


