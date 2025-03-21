Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :users
  resources :artists do
    collection do
      get :export
      post :import
      get :options
    end
  end
  resources :musics

  get "dashboard" => "dashboard#index"

  get "up" => "rails/health#show", as: :rails_health_check


  get '404', :to => 'application#page_not_found'
end
