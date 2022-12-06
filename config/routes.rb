Rails.application.routes.draw do
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
    root to: "genres#index"
    resources :users, only:[:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :infos, only: [:index, :show, :edit, :update, :destroy] do
    resources :info_comments, only: [:create, :destroy]
    end
  end

  scope module: :public do #scope moduleでurlにpublicと付ける必要がなくなる
    root to: "homes#top"
    resources :users, only:[:index, :show, :edit, :update]
    resources :infos, only:[:index, :show, :edit,:create, :destroy, :update] do
      resource :bookmarks, only: [:create, :destroy]
      resources :info_comments, only: [:create, :destroy]
    end
  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
