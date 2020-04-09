class QuestionsController < ApplicationController
  include UsersHelper
  before_action :authenticate_admin!
  
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @survey = Survey.find(session[:survey_id])
    @questions = @survey.questions
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.survey = Survey.find(session[:survey_id])

    respond_to do |format|
      if @question.save
        format.html { redirect_to after_create_path, success: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
        format.js
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
        format.html { redirect_to after_update_path, success: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to after_destroy_path, success: 'Question was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
      after_create_path
    end

    def after_create_path
      survey_path(id: @question.survey.id)
    end

    def after_update_path
      after_create_path
    end

    def after_destroy_path
      after_create_path
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:name, :mcq)
    end
end
