Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get "subscriptions", to: "subscriptions#show"
      post "subscribe", to: 'subscriptions#create'
      post "unsubscribe", to: 'subscriptions#delete'
    end
  end
end
