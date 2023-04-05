Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users
  resources :users, only: [:index, :show, :edit, :update] do
    patch '/users/:id/stop' => 'users#stop', as: 'stop'
  end
  resources :posts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
