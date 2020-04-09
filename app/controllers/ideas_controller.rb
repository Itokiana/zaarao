class IdeasController < SpacesController
  
  include ApplicationHelper

  before_action :set_idea, only: [:show, :edit, :update, :admin_update, :destroy]
  before_action :authenticate_user
  before_action :set_space
  before_action :authenticate_admin, only: [:index, :admin_update]

  # GET /ideas
  # GET /ideas.json
  def index
  end


  # GET /ideas/1
  # GET /ideas/1.json
  def show
    @positive_ratings = @idea.get_likes
    @negative_ratings = @idea.get_dislikes
    unless current_user.viewed(@idea)
      add_viewer(user_id=current_user.id, project_id=0, idea_id=@idea.id, survey_id=0, call_for_idea_id=0, actuality_id=0)
    end
  end

  # GET /ideas/new
  def new
    @idea = Idea.new
  end

  # GET /ideas/1/edit
  def edit
  end

  # POST /ideas
  # POST /ideas.json
  def create
    # AddIdeaWorker.perform_async(idea_params.to_hash, current_user.id)
    @idea = current_user.ideas.new(idea_params)
    @idea.space = current_user.space

    respond_to do |format|
      if @idea.save
        format.html { redirect_to after_create_path, success: t('idea.create') }
        format.json { render :show, status: :ok, location: @idea }
      else
        format.html { render :new, danger: @idea.errors.full_messages }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ideas/1
  # PATCH/PUT /ideas/1.json
  def update
    respond_to do |format|
      if @idea.update(update_idea_params)
        format.html { redirect_to (current_user.is_admin? ? after_update_path : after_create_path), success: t('idea.update') }
        format.json { render :show, status: :ok, location: @idea }
        format.js
      else
        format.html { render :edit, danger: @idea.errors.full_messages }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  def admin_update
    respond_to do |format|
      if @idea.update(ready: true)
        format.html { redirect_to (current_user.is_admin? ? after_update_path : after_create_path), success: t('idea.update') }
        format.js
      else
        format.html { redirect_to share_an_idea_path, danger: @idea.errors.full_messages }
        format.js
      end
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    @idea_id = @idea.id
    @idea.destroy
    respond_to do |format|
      format.html { redirect_to my_space_path, success: t('idea.destroy') }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_idea
      @idea = Idea.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def idea_params
      params.require(:idea).permit(:type_id, :name, :description, :cover_picture, :call_for_idea_id)
    end

    def update_idea_params
      params.require(:idea).permit(:type_id, :name, :description, :cover_picture, :ready, :on)
    end

    def admin_update_idea_params
      params.require(:idea).permit(:ready)
    end

    def authenticate_user
      authenticate_user!

      unless current_user.complete?
        redirect_to edit_user_registration_path,
        warning: t('idea.valide.completed')
      end

      if action_name=="show"
        unless @idea.ready?
          redirect_to edit_idea_path(id: @idea.id),
          warning: t('idea.valide.public')
        end
      end

      if action_name=="edit" || action_name=="update"
        unless current_user == @idea.admin
          redirect_to "/404.html"
        end
      end
    end

    def authenticate_admin
      unless (current_user.admin? && current_user.space == current_user.main_space) || current_user.super_admin?
        redirect_to "/404.html"
      end
    end

    def after_create_path
      if @idea.ready? && @idea.has_one_call_for_idea?
        call_for_idea_path(id: @idea.call_for_idea.id)
      elsif !@idea.ready?
        edit_idea_path(id: @idea.id)
      else
        idea_path(id: @idea.id)
      end
    end

    def after_update_path
      edit_my_space_path
    end
end
