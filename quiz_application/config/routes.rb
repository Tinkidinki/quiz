Rails.application.routes.draw do

  root "pages#show", page: "home"
  
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :users
  resources :questions
  resources :quizzes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
