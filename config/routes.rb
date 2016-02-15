require 'api_constraints'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
  #
  root :to => "static_pages#home"
  # get 'static_pages/home'
  #

  # namespace :api, defaults: { format: :json }, path: '/', :constraints => {:subdomain => "api"} do
  namespace :api, defaults: { format: :json }, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      # route the registration stuff to registrations controller
      resources :users, only: [:create, :update, :destroy], controller: 'registrations'

      # route the confirmation stuff to the confirmation controller
      # do resource (singular) to eliminate the ID param in the path
      resource :users, only: [] do
        resource :confirmations, only: [:show], controller: 'confirmations'
      end

      resources :users, only: [:index, :show]
      #match 'users/confirmation', via: :get, as: 'confirmation', to: 'confirmations#show'

    end
  end

  match '*path', to: -> (env) {
    [400, { 'Content-Type' => 'application/json' },
      [{ status: 404, error: 'Route Not Found' }.to_json]]
      }, via: :all
end
