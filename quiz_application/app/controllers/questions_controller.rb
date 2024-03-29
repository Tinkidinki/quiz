class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.where(quiz_id: params[:id])
  end

  

  # GET /questions/1
  # GET /questions/1.json
  def show
	@question = Question.find_by(id: params[:id])
	@quiz_id = @question.quiz_id
  end

  # GET /save_question_attempt
  def save_question_attempt
	@question_id = params[:id]
	@question = Question.where(id: @question_id).first
    @user_id = session[:user_id]
    @quiz_id = @question.quiz_id

    @question_attempt = QuestionAttempt.new
    @question_attempt.question_id = @question_id
    @question_attempt.user_id = @user_id

    @user_options = []

    if params[:option_1]
      @user_options << 1
    end

    if params[:option_2]
      @user_options << 2
    end
     
    if params[:option_3]
      @user_options << 3
    end

    if params[:option_4]
      @user_options << 4
    end
  
		@question_attempt.user_options = @user_options
		@question_attempt.save

		redirect_to play_quiz_path(id: @quiz_id)
	end


  # GET /questions/new
  def new
	@quiz_id = params[:id]
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
	@question = Question.find_by(id: params[:id])
	@quiz_id = @question.quiz_id

  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
	@quiz_id = @question.quiz_id
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_path(id: @quiz_id), notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:quiz_id, :question_statement, :option_1, :option_2, :option_3, :option_4, :correct_options)
    end
end
