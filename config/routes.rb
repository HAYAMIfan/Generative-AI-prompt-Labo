Rails.application.routes.draw do
  get 'relationships/followings'
  get 'relationships/followers'
  root to: 'homes#top'
  devise_for :users, controllers: {
  sessions: 'users/sessions'
}
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :users, only: %i[index show edit update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    member do
      patch 'stop'
      patch 'restore'
    end
    collection do
      get 'search'
    end
  end
  resources :posts do
    collection do
      get 'search'
    end
    resource :favorites , only: %i[create destroy]
    resources :post_comments, only: %i[create destroy]
  end
  resources :tags do
    get 'posts', to: 'posts#search'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
