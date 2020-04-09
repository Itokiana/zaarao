class ProjectsController < SpacesController
  
  include ProjectsHelper
  include ApplicationHelper

  before_action :authenticate_user
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_project, only: [:show, :edit]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.safe_all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @call_for_ideas = @project.call_for_ideas
    unless current_user.viewed(@project)
      add_viewer(user_id=current_user.id, project_id=@project.id, idea_id=0, survey_id=0, call_for_idea_id=0, actuality_id=0)
    end
  end

  # GET /projects/new
  def new
    @project = current_space.projects.new
  end

  # GET /projects/1/edit
  def edit
    @call_for_ideas = @project.call_for_ideas
  end

  # POST /projects
  # POST /projects.json
  def create
    deadline = params[:project][:deadline]
    @project = current_space.projects.new(project_params)
    @project.deadline = customized_date
    @project.admin = current_user

    respond_to do |format|
      if @project.save
        format.html { redirect_to edit_project_path(id: @project.id), info: t('projects.create') }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { redirect_to create_a_project_path, danger: @project.errors.full_messages }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_path(id: @project.id), success: t('projects.update') }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { redirect_to edit_project_path(id: @project.id), danger: @porject.errors.full_messages }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, success: t('projects.destroy') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :description, :type_id, :ready, :cover_picture)
    end

    def authenticate_user
      authenticate_user!
      if action_name=="edit"
        @project = set_project
        unless current_user.is_admin?
          redirect_to "/404.html"
        end
      end
      if action_name != "new" && action_name != "create"
        @project = set_project
      end
    end

    def authenticate_project
      if action_name=="show" && !@project.ready?
        redirect_to edit_project_path(id: @project.id),
        warning: t('projects.warning')
      end
      # if action_name=="edit" && @project.ready?
      #   redirect_to project_path(id: @project.id),
      #   warning: t('projects.editable')
      # end
    end

    def customized_date
      deadline = params[:project][:deadline]
      day = deadline.split("/")[1]
      month = deadline.split("/")[0]
      year = (deadline.split("/")[2]).split(' ')[0]
      time = (deadline.split("/")[2]).split(' ')[1]
      am_or_pm = (deadline.split("/")[2]).split(' ')[2]
      final_date = day+'th'+" "+month+" "+year+" "+time+" "+am_or_pm
      final_date
      final_date.to_datetime
    end
end
