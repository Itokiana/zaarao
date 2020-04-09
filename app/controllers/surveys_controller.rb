class SurveysController < SpacesController  
  before_action :authenticate_user!
  before_action :authenticate_admin, only: %i[edit update new create destroy]
  before_action :set_survey, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_survey, only: [:show, :edit]

  include ApplicationHelper
  include SpacesHelper
  include SurveysHelper
  # GET /surveys
  # GET /surveys.json
  def index
    @surveys = Survey.safe_all
  end

  # GET /surveys/1
  # GET /surveys/1.json
  def show
    unless current_user.viewed(@survey)
      add_viewer(user_id=current_user.id, project_id=0, idea_id=0, survey_id=@survey.id, call_for_idea_id=0, actuality_id=0)
    end
  end

  # GET /surveys/new
  def new
    @survey = Survey.new
  end

  # GET /surveys/1/edit
  def edit
  end

  # POST /surveys
  # POST /surveys.json
  def create
    end_date = params[:survey][:end_date]
    @survey = current_space.surveys.new(survey_params)
    @survey.end_date = customized_date
    @survey.admin = current_user

    respond_to do |format|
      if @survey.save
        format.html { redirect_to edit_survey_path(id: @survey.id), info: t('surveys.add') }
        format.json { render :show, status: :created, location: @survey }
      else
        format.html { redirect_to create_a_survey_path, danger: @survey.errors.full_messages }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surveys/1
  # PATCH/PUT /surveys/1.json
  def update
    respond_to do |format|
      if @survey.update(update_survey_params)
        format.html { redirect_to survey_path(id: @survey.id), success: t('surveys.update') }
        format.json { render :show, status: :ok, location: @survey }
      else
        format.html { redirect_to edit_survey_path(id: @survey.id), danger: @survey.errors.full_messages }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.json
  def destroy
    @survey.destroy
    respond_to do |format|
      format.html { redirect_to surveys_url, success: t('surveys.destroy') }
      format.json { head :no_content }
    end
  end

  def answer
    @survey = set_survey
    options = []
    params.require(:question).each do |key, value|
      options << Option.find(value)
    end
    if params[:option]
      params.require(:option).each do |key, value|
        options << Option.find(value)
      end
    end
    options.each do |option|
      option.users.push(current_user)
    end
    respond_to do |format|
      if options.any?
        format.html { redirect_to survey_path(id: @survey.id), success: t('surveys.success') }
        format.js
      else
        format.html { redirect_to survey_path(id: @survey.id), danger: "Unknown error" }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = current_survey
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_params
      params.require(:survey).permit(:type_id, :name, :description, :end_date, :cover_picture)
    end

    def update_survey_params
      params.require(:survey).permit(:type_id, :name, :description, :ready, :cover_picture)
    end

    def authenticate_admin
      unless (current_user.admin? && current_space == current_user.main_space) || current_user.super_admin?
        redirect_to '/404.html'
      end
    end

    def authenticate_survey
      if action_name=="show" && !@survey.ready?
        redirect_to edit_survey_path(id: @survey.id),
        warning: t('surveys.warning')
      end
      if action_name=="edit" && @survey.ready?
        redirect_to survey_path(id: @survey.id),
        warning: t('surveys.editable')
      end
    end

    def customized_date
      end_date = params[:survey][:end_date]
      day = end_date.split("/")[1]
      month = end_date.split("/")[0]
      year = (end_date.split("/")[2]).split(' ')[0]
      time = (end_date.split("/")[2]).split(' ')[1]
      am_or_pm = (end_date.split("/")[2]).split(' ')[2]
      final_date = day+'th'+" "+month+" "+year+" "+time+" "+am_or_pm
      final_date
      final_date.to_datetime
    end
end
