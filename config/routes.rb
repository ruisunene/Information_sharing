Rails.application.routes.draw do
  namespace :admin do
    get 'tags/show'
  end
  devise_for :admin, skip: [:registrations,:passwords] ,controllers:{
    sessions: "admin/sessions"
  }

  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  namespace :admin do
    root to: "infos#index"
    resources :users, only:[:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :tags, only: [:show, :destroy ]
    resources :infos, only: [:index, :show, :edit, :update, :destroy] do
    resources :info_comments, only: [:create, :destroy, :edit, :update]
    end
    resources :groups do
      delete "all_destroy" => 'groups#all_destroy'
    end
  end

  scope module: :public do #scope moduleでurlにpublicと付ける必要がなくなる
   root to: "homes#top"
    resources :users, only:[:index, :show, :edit, :update] do
      get 'chat/:id', to: 'chats#show', as: 'chat'
      resources :chats, only: [:create]
      resource :relationships, only: [:create, :destroy]
  	  get 'followings' => 'relationships#followings', as: 'followings'
  	  get 'followers' => 'relationships#followers', as: 'followers'
    end
    resources :tags, only: [:show]
    resources :infos do
      resource :bookmarks, only: [:create, :destroy]
      resources :info_comments, only: [:create, :destroy, :edit,:update]
      resources :memos, only: [:create, :destroy, :edit, :update]
      #get '/search', to: 'searches#search'ここだとエラー
    end
    resources :groups do
      get "join" => "groups#join"
        delete "all_destroy" => 'groups#all_destroy'
    end
  end

  get '/search', to: 'searches#search'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
