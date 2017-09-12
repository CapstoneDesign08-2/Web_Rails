Rails.application.routes.draw do
 # get 'applicants/:id/upload' => 'applicants#upload', as: 'upload_applicant'

  resources :applicants
  resources :challenges

  get '/applicants/logging/:id/', to: 'applicants#logging'
  get '/applicants/score/:id/', to: 'applicants#score'
  get '/challenges/result/:id/', to: 'challenges#result'
  post '/applicants/:id' => 'applicants#building', as: 'building_applicant'
  root :to => 'applicants#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
