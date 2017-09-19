class QuizzesController < ApplicationController
  before_action :set_quiz, only: [:show, :edit, :update, :destroy]

  # GET /quizzes
  # GET /quizzes.json
  def index
    @quizzes = Quiz.all
  end

  #GET /play_quiz/quiz_id
  def play_quiz
    @quiz = Quiz.where(id: params[:id]).first
    @questions = Question.where(quiz_id: params[:id])
    @quiz_attempt = QuizAttempt.where(quiz_id: @quiz.id, user_id: session[:user_id]).first
    if not @quiz_attempt
      @quiz_attempt = QuizAttempt.new(quiz_id: params[:id] ,user_id: session[:user_id])
      @quiz_attempt.save
    end
    #@questions = Question.all
  end

  #GET /score/<QuizAttempt_id>
  def score
    @quiz_attempt_id = params[:id]
    @user_id = session[:user_id]
    @quiz_attempt = QuizAttempt.find_by(id: @quiz_attempt_id)
    @quiz_id = @quiz_attempt.quiz_id
    @question_attempts = QuestionAttempt.joins(:question).where(questions: {quiz_id: @quiz_id}, user_id: @user_id).all

    @quiz_attempt.score = 0
    #validating the answers
    @question_attempts.each do |question_attempt|
      if eval(question_attempt.user_options).sort == eval(question_attempt.question.correct_options).sort
        @quiz_attempt.score +=1 
      end
    end

    @quiz_attempt.save

    respond_to do |format|
      format.html{ redirect_to play_quiz_path(@quiz_id, done: true), notice: "You are done!Your score is #{@quiz_attempt.score}"}
    end
  end

  #GET "/leaderboard/<quiz_id>"
  def leaderboard
    @quiz_id = params[:id]
    @quiz_attempts = QuizAttempt.order('score desc').where(quiz_id: @quiz_id)
  end

  # GET /quizzes/new
  def new
    @quiz = Quiz.new
  end

  # GET /quizzes/1/edit
  def edit
  end

  # POST /quizzes
  # POST /quizzes.json
  def create
    @quiz = Quiz.new(quiz_params)

    respond_to do |format|
      if @quiz.save
        format.html { redirect_to @quiz, notice: 'Quiz was successfully created.' }
        format.json { render :show, status: :created, location: @quiz }
      else
        format.html { render :new }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quizzes/1
  # PATCH/PUT /quizzes/1.json
  def update
    respond_to do |format|
      if @quiz.update(quiz_params)
        format.html { redirect_to @quiz, notice: 'Quiz was successfully updated.' }
        format.json { render :show, status: :ok, location: @quiz }
      else
        format.html { render :edit }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quizzes/1
  # DELETE /quizzes/1.json
  def destroy
    @quiz.destroy
    respond_to do |format|
      format.html { redirect_to quizzes_url, notice: 'Quiz was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quiz_params
      params.require(:quiz).permit(:genre, :sub_genre)
    end
end
