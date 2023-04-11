Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users, controllers: {
  sessions: 'users/sessions'
}
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :users, only: [:index, :show, :edit, :update] do
    member do
      patch 'stop'
    end
  end

  resources :posts do
    resource :favorites , only: [:create , :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
