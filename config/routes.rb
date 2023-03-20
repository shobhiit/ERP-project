
Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  post 'upload' , to: 'timesheets#create'
  get 'show' , to: 'timesheets#show'
end