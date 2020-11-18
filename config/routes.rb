Rails.application.routes.draw do
   # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  #deviseの設定
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  #letteropenerの設定
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  #userのroute設定
  resources :users
  #初期画面をquestion indexに設定
  root to: 'questions#index'
  #questionのroute設定
  resources :questions do
    resources :answers, only: [:create]
  end

  resources :answers, only: [:create] do
    resources :likes, only: [:create, :destroy]
  end

end

