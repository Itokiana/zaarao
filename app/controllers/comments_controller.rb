class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: %i[edit update destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comment = current_user.comments.new
    if params[:idea_id] != 0
      @idea = Idea.find(params[:idea_id])
      @comments = @idea.comments
    elsif params[:project_id] != 0
      @project = Project.find(params[:project_id])
      @comments = @project.comments
    end
    @comments = @comments.limit(10)
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = current_user.comments.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @item_type = params[:item_type]
    if @item_type == "idea"
      @item = Idea.find(params[:item_id]) if params[:item_id]
      after_create_path = idea_path(id: @item.id)
    elsif @item_type == "comment"
      @item = Comment.find(params[:item_id]) if params[:item_id]
      if @item.commentable_type.underscore=="idea"
        after_create_path = idea_path(id: @item.commentable_id)
      elsif @item.commentable_type.underscore=="survey"
        after_create_path = survey_path(id: @item.commentable_id)
      elsif @item.commentable_type.underscore=="project"
        after_create_path = project_path(id: @item.commentable_id)
      elsif @item.commentable_type.underscore=="call_for_idea"
        after_create_path = call_for_idea_path(id: @item.commentable_id)
      elsif @item.commentable_type.underscore=="actuality"
        after_create_path = actuality_path(id: @item.commentable_id)
      end
      @defcon = 1
    elsif @item_type == "project"
      @item = Project.find(params[:item_id]) if params[:item_id]
      after_create_path = project_path(id: @item.id)
    elsif @item_type == "survey"
      @item = Survey.find(params[:item_id]) if params[:item_id]
        after_create_path = survey_path(id: @item.id)
    elsif @item_type == "call_for_idea"
      @item = CallForIdea.find(params[:item_id]) if params[:item_id]
      after_create_path = call_for_idea_path(id: @item.id)
    elsif @item_type == "actuality"
      @item = Actuality.find(params[:item_id]) if params[:item_id]
      after_create_path = actuality_path(id: @item.id)
    end

    @defcon ||= 0

    @comment = Comment.build_from( @item, current_user.id, params[:comment][:content] )

    respond_to do |format|
      if @comment.save
        format.html { redirect_to after_create_path, success: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
        format.js
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(update_comment_params)
        format.html { redirect_to after_update_path, success: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { redirect_to edit_comment_path(id: @comment.id), danger: @comment.errors.full_messages }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to after_update_path, success: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:project, :content)
    end

    def update_comment_params
      params.require(:comment).permit(:content)
    end

    # def update(comment)
    #   comment.update(comment_params)
    # end

    def after_update_path
      if @comment.idea
        return idea_path(id: @comment.wyc_id)
      elsif @comment.project
        return project_path(id: @comment.wyc_id)
      else
        return root_path
      end
    end

    def authenticate_user
      unless current_user.comments.include?(@comment)
        redirect_to "/404.html"
      end
    end
end
