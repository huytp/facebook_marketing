Rails.application.routes.draw do
  resources :user_sells, only: [] do
    collection do
      get ':user_id', to: 'user_sells#show', as: :user_sells
    end
  end
  resources :extends, only: [] do
    collection do
      get ':customer_id', to: 'extends#show', as: "day_using"
      post ':customer_id', to: 'extends#update'
    end
  end
  resources :service_tables
  resources :user_infos, only: [:index]

  apipie
  root 'homes#index'
  resources :homes do
    collection do
      patch '/ban/:id', to: 'homes#ban', as: 'ban'
      patch '/unban/:id', to: 'homes#unban', as: 'unban'
      get 'update_version', to: "homes#update_version", as: "update_version"
      post 'update_version', to: "homes#update_version_value"
      get 'inform', to: "homes#inform", as: "inform"
      post 'inform', to: "homes#inform_value"
    end
  end
  devise_for :users

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :customers, only: [:create] do
        collection do
          get 'get_current_version', to: 'customers#get_current_version'
          get 'check_is_member', to: 'customers#check_is_member'
          get 'check_is_member_valid', to: 'customers#check_is_member_valid'
          get 'get_inform', to: 'customers#get_inform'
          get 'get_times', to: 'customers#get_times'
        end
      end
      resources :tokens, only: [] do
        collection do
          post 'get_token_facebook', to: 'tokens#get_token_facebook'
        end
      end
      resources :add_friends, only: [] do
        collection do
          get 'invite_friend', to: 'add_friends#invite_friend'
        end
      end
      match '*other', :to => 'base_api#routing_error', via: [:get, :post, :put]
    end
  end
end
