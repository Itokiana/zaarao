class OptionsController < ApplicationController
  include UsersHelper
  before_action :authenticate_admin!
  before_action :set_option, only: [:show, :edit, :update, :destroy]

  # GET /options
  # GET /options.json
  def index
    @options = Option.safe_all
  end

  # GET /options/1
  # GET /options/1.json
  def show
  end

  # GET /options/new
  def new
    @option = Option.new
  end

  # GET /options/1/edit
  def edit
  end

  # POST /options
  # POST /options.json
  def create
    @question = set_question
    @option = Option.new(option_params)

    respond_to do |format|
      if @option.save
        format.html { redirect_to edit_survey_path(id: @option.question.survey.id), success: 'Option was successfully created.' }
        format.json { render :show, status: :created, location: @option }
        format.js
      else
        format.html { render :new }
        format.json { render json: @option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /options/1
  # PATCH/PUT /options/1.json
  def update
    @question = set_question
    
    respond_to do |format|
      if @option.update(option_params)
        format.html { redirect_to edit_survey_path(id: @option.question.survey.id), success: 'Option was successfully updated.' }
        format.json { render :show, status: :ok, location: @option }
      else
        format.html { render :edit }
        format.json { render json: @option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /options/1
  # DELETE /options/1.json
  def destroy
    @survey = @option.question.survey
    @option.destroy
    respond_to do |format|
      format.html { redirect_to edit_survey_path(id: @survey.id), success: 'Option was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_option
      @option = Option.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def option_params
      params.require(:option).permit(:question_id, :name, :cover_picture)
    end

    def set_question
      @question = Question.find(params[:option][:question_id])
    end
end
