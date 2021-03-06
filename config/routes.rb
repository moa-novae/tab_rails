Rails.application.routes.draw do
  scope '/api' do
    devise_for :users,
                 path: '',
                 path_names: {
                   sign_in: 'login',
                   sign_out: 'logout',
                   registration: 'signup'
                 },
                 controllers: {
                   sessions: 'sessions',
                   registrations: 'registrations'
                 }
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    resources :groups
    resources :transactions
    get 'profile', to: 'users#index'
    resources :users, except: :index
  end
end
