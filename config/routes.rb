# frozen_string_literal: true

Rails.application.routes.draw do
  get '/offenders/:jurisdiction/:id' => 'offenders#show', as: :offender
  post '/offenders/:jurisdiction' => 'offender_jurisdictions#search'
  get '/offenders/:jurisdiction' => 'offender_jurisdictions#show', as: :offender_jurisdiction
  get '/offenders/:id', to: redirect('/offenders/oregon/%<id>') # deprecated!

  get '/offenders', to: 'offender_jurisdictions#index', as: :offenders
  post '/offenders/:jurisdiction', to: 'offender_jurisdictions#search'

  get '/feedback/:id' => 'feedback_responses#show', id: /\d+/
  get '/feedback/:type' => 'feedback_responses#create', as: :feedback_response
  patch '/feedback/:id' => 'feedback_responses#update'

  namespace :admin do
    resources :digital_vrns, only: %i[index show]
    resource :import_status, only: %i[show]
  end

  resources :rights, only: %i[show index create destroy], id: Regexp.union(RightsFlow::PAGES) do
    collection do
      post '/:id', to: 'rights#update'
      delete '/', to: 'rights#delete'
      get '/preview', to: 'rights#preview'
    end
  end

  resources :faqs, only: %i[show index]

  resources :mailchimp_csvs, only: %i[show]

  resource :styleguide, only: %i[show]

  resource :sessions, only: %i[new create destroy]
  resources :users, only: %i[edit update]

  get '/t/:tracking_id', to: 'home#set_tracking'

  get '/trigger-error', to: 'home#trigger_error'
  get '/sandbox', to: 'home#sandbox'
  get '/health', to: 'home#health'
  get '/home', to: 'home#home'

  root to: 'home#splash'
end
