class CallForIdeasController < ApplicationController
  layout 'spaces'
  include ApplicationHelper
  include UsersHelper

  before_action :set_call_for_idea, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authenticate_admin, only: %i[new create edit update destroy]

  # GET /call_for_ideas
  # GET /call_for_ideas.json
  def index
    @project = Project.find(params[:project_id])
    @call_for_ideas = @project.call_for_ideas
  end

  # GET /call_for_ideas/1
  # GET /call_for_ideas/1.json
  def show
    @ideas = @call_for_idea.ready_ideas
    @positive_ratings = @call_for_idea.positive_ratings
    @negative_ratings = @call_for_idea.negative_ratings
    unless current_user.viewed(@call_for_idea)
      add_viewer(user_id=current_user.id, project_id=0, idea_id=0, survey_id=0, call_for_idea_id=@call_for_idea.id, actuality_id=0)
    end
  end

  # GET /call_for_ideas/new
  def new
    @call_for_idea = CallForIdea.new
  end

  # GET /call_for_ideas/1/edit
  def edit
  end

  # POST /call_for_ideas
  # POST /call_for_ideas.json
  def create
    puts "Create"*23
    puts params.inspect
    puts "Create"*23
    @project = Project.find(params[:call_for_idea][:project_id])
    @call_for_idea = CallForIdea.new(call_for_idea_params)
    @call_for_idea.type = @project.type

    respond_to do |format|
      if @call_for_idea.save
        format.html { redirect_to edit_project_path(id: @call_for_idea.project.id), success: 'Call for idea was successfully created.' }
        format.json { render :show, status: :created, location: @call_for_idea }
        format.js
      else
        format.html { redirect_to edit_project_path(id: @call_for_idea.project.id), danger: @call_for_idea.errors.full_messages }
        format.json { render json: @call_for_idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /call_for_ideas/1
  # PATCH/PUT /call_for_ideas/1.json
  def update
    respond_to do |format|
      if @call_for_idea.update(call_for_idea_params)
        @project = @call_for_idea.project
        format.html { redirect_to edit_project_path(id: @call_for_idea.project.id), success: 'Call for idea was successfully updated.' }
        format.json { render :show, status: :ok, location: @call_for_idea }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @call_for_idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /call_for_ideas/1
  # DELETE /call_for_ideas/1.json
  def destroy
    @project = @call_for_idea.project
    @call_for_idea.destroy
    respond_to do |format|
      format.html { redirect_to edit_project_path(id: @call_for_idea.project.id), success: 'Call for idea was successfully deleted.' }
      format.json { head :no_content }
      format.js
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_call_for_idea
      @call_for_idea = CallForIdea.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def call_for_idea_params
      params.require(:call_for_idea).permit(:project_id, :name, :description, :cover_picture)
    end
end
