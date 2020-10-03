Rails.application.routes.draw do
  resources :friendships
  resources :members do
    get :find_experts, on: :member
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
