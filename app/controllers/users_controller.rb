class UsersController < ApplicationController
  layout 'spaces', only: [:index]
  before_action :authenticate_user!
  before_action :authenticate_admin!, only: %i[index]
	include UsersHelper
  
  def index
    @users = current_user.space.members

    @usernames = [] 
    @available_users.each do |user|
      @usernames << user.fullname
    end
  end

  def show
    @user = params[:id] ? User.find(params[:id]) : current_user
    @ideas = @user.ideas
    @ipagy, @items = pagy(@ideas, items: 10)
    @surveys = @user.surveys
    @spagy, @items = pagy(@surveys, items: 10)
    @projects = @user.projects
    @ppagy, @items = pagy(@projects, items: 10)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
  	@spaces = Space.safe_all
  	@languages = Language.safe_all
  end

  def update
  	@user = current_user
    if @user.update(user_params)
      respond_to do |format|
        format.html{
          redirect_to root_path,
          success: "OK"
        }
        format.js
      end
    else
      respond_to do |format|
        format.html{
          redirect_to root_path,
          danger: @user.errors.full_messages
        }        
      end
    end
  end

  def kick_out
    @user = User.find(params[:id])
    if @user && current_user.is_admin?
      new_spaces = []
      @user.visited_spaces.each do |space|
        new_spaces << space if space != space
      end
      @user.visited_spaces = new_spaces
    end
    respond_to do |format|
      format.html { redirect_to users_path, success: @user.fullname + "has been kicked out successfully"}
    end
  end

  protected
  def user_params
    params.require(:user).permit(:language_id)
  end
end
