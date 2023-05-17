Rails.application.routes.draw do
  
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
  devise_scope :user do
    get 'profil', to: 'devise/registrations#edit'
    get 'student-sign-in', to: 'devise/sessions#new'
    get 'student-sign-up', to: 'devise/registrations#new', as: "new_user_registration"
    delete 'deconnecter',  to: "devise/sessions#destroy", as: "destroy_user_session_path"
  end
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "homepage#index"
end
