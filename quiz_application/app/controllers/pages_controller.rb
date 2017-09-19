class PagesController < ApplicationController
    def show
      render template: "pages/#{params[:page]}"
    end

    def home
      if session[:user_id]
        redirect_to quizzes_path
      end
    end
end