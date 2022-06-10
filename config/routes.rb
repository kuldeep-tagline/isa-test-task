# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  # root "articles#index"
  namespace 'api' do
    namespace 'v1', defaults: { format: :json } do
      resources :users, only: [] do
        collection do
          post 'sign-in'
          post 'sign-up'
        end
      end
      resources :jobs, only: %i[index create]
    end
  end

  match '*unmatched', to: 'application#render_4041', via: :all
end
