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

  #Non scaffolded routes

  get "/save_question_attempt/:id" , to: "questions#save_question_attempt", as: :save_question_attempt
  get "/play_quiz/:id", to: "quizzes#play_quiz", as: :play_quiz
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
