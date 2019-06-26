Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  get '/csvfiles', to: 'comments#csv_files'
  get '/displaycsv', to: 'comments#display_csv_imported'
  resources :projects
  resources :tasks do
    resources :comments
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
