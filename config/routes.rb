Rails.application.routes.draw do
  
  
  # Defines the root path route ("/") and Feed course
  root "homepage#index"
  get "feed", to:'feed#index'
  
  ################## LEARN POD  ##########################
  get "new-article", to:"articles#new"
  get "articles", to:"articles#index"
  resources :articles, except: %i[:new, :index]

  ################## COURSES  ##########################
  get "new-course", to:"courses#new"
  resources :courses, except:[:new]
  
  
  ################## STATUTS  ##########################
  get "new-statut", to:"statuts#new"
  resources :statuts, except:[:new]
  
  
  ################## MATERIALS  ##########################
  get "new-material", to:"materials#new"
  resources :materials, except:[:new]

  ################## LEVELS  ##########################
  get "new-level", to:"levels#new"
  resources :levels, except:[:new]
  
  
  ################## DASHBOARD  ##########################
  get "dashboard", to:'dashboard#index'
  
  ################## USERS  ##########################
  
  devise_for :users, controllers: { registrations: 'users/registrations' }

  namespace :users do
    resources :registration_steps, only: [:show, :update], controller: 'registration_steps'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

end
