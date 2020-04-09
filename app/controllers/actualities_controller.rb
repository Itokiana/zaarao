class ActualitiesController < SpacesController
  
  include ApplicationHelper
  include UsersHelper
  include SpacesHelper

  before_action :authenticate_admin!, only: %i[new create edit update destroy]
  before_action :set_actuality, only: [:show, :edit, :update, :destroy]
  respond_to :js, :json , :html

  # GET /actualities
  # GET /actualities.json
  def index
    @actualities = Actuality.safe_all
  end

  # GET /actualities/1
  # GET /actualities/1.json
  def show
    unless current_user.viewed(@actuality)
      add_viewer(user_id=current_user.id, project_id=0, idea_id=0, survey_id=0, call_for_idea_id=0, actuality_id=@actuality.id)
    end
  end

  # GET /actualities/new
  def new
    @actuality = Actuality.new
  end

  # GET /actualities/1/edit
  def edit
  end

  # POST /actualities
  # POST /actualities.json
  def create
    @actuality = Actuality.new(actuality_params)
    @actuality.admin = current_user
    @actuality.space = current_user.main_space

    respond_to do |format|
      if @actuality.save
        format.html { redirect_to actuality_path(id: @actuality.id), success: t('actualities.create')  }
        format.json { render :show, status: :created, location: @actuality }
      else
        format.html { render :new }
        format.json { render json: @actuality.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /actualities/1
  # PATCH/PUT /actualities/1.json
  def update
    respond_to do |format|
      if @actuality.update(actuality_params)
        format.html { redirect_to actuality_path(id: @actuality.id), success: t('actualities.update') }
        format.json { render :show, status: :ok, location: @actuality }
      else
        format.html { render :edit }
        format.json { render json: @actuality.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /actualities/1
  # DELETE /actualities/1.json
  def destroy
    @actuality.destroy
    respond_to do |format|
      format.html { redirect_to actualities_url, success: t('activities.destroy') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_actuality
      @actuality = Actuality.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def actuality_params
      params.require(:actuality).permit(:name, :description)
    end

    def authenticate_property
      unless current_user.actualities.include?(@actuality)
        redirect_to "/404.html"
      end
    end
end
