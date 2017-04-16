Rails.application.routes.draw do
  resources :charges do
    collection do
      get :preview
      get :success
      get :subscribe
      post :conversation_subscription
    end
  end
  resources :sms_messages
  resources :converstation_requests
  resources :requesters
  resources :registered_numbers
  resources :experts

  resources :sms_hooks do
    collection do
      get :receive_conversation_request
      get :connect_conversation
    end
  end

  root to: 'visitors#index'
  devise_for :users
end
