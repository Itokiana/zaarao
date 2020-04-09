class SpacesController < ApplicationController
  layout 'spaces'

  include Pagy::Backend

  include UsersHelper
  include SpacesHelper
  include SearchesHelper

  before_action :authenticate_user!, only: %i[new create edit update]
  before_action :authenticate_admin, only: %i[new create edit update switch_admin]
  before_action :set_space


  # GET /spaces
  # GET /spaces.json
  def index
    @fullideas = @space.ideas.ready?
    @fullsurveys = @space.surveys.ready?
    @fullprojects = @space.projects.ready?
    @fullactualities = @space.actualities

    @item_type = 'all'
    @result = search("*")
    @pagy, @fullall = pagy_array(@result, page_param: :all_page, items: 12)
    @items = Kaminari.paginate_array(@result).page(params[:page]).per(12)

    
    @ideas_pagy, @ideas = pagy(@fullideas, page_param: :ideas_page)
    @surveys_pagy, @surveys = pagy(@fullsurveys, page_param: :surveys_page)
    @projects_pagy, @projects = pagy(@fullprojects, page_param: :projects_page)
    @actualities_pagy, @actualities = pagy(@fullactualities, page_param: :actualities_page)

    respond_to do |format|
      format.html { render :index }
      format.js
    end
  end

  # GET /spaces/1
  # GET /spaces/1.json
  def show
    @space = params[:name] ? search_space(params[:name]) : current_space
  end

  # GET /spaces/new
  def new
    @space = Space.new
  end

  # GET /spaces/1/edit
  def edit
    @users = @space.members
    @upagy, @uitems = pagy(@users, page_param: :upage, items: 10)
    
    @ideas = @space.on_ideas
    @ipagy, @iitems = pagy_array(@ideas, page_param: :ipage, items: 10)
    
    @off_ideas = @space.off_ideas
    @off_ipagy, @off_iitems = pagy_array(@off_ideas, page_param: :off_ipage, items: 10)
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /spaces
  # POST /spaces.json
  def create
    @space = Space.new(space_params)

    respond_to do |format|
      if @space.save
        format.html { redirect_to @space, success: 'Space was successfully created.' }
        format.json { render :show, status: :created, location: @space }
      else
        format.html { render :new }
        format.json { render json: @space.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spaces/1
  # PATCH/PUT /spaces/1.json
  def update
    @oldadmin = current_user

    if @space.update(update_space_params)
      if @space.admin_id != @oldadmin.id
        @space.admin.update(admin: true)
        current_user.update(admin: false)

        sign_out(@oldadmin)
        
        respond_to do |format|
          format.html{ redirect_to my_space_path, success: t("spaces.update") }
        end
      else
        respond_to do |format|
          format.html { redirect_to my_space_path, success: t("spaces.update") }
          format.json { render :show, status: :ok, location: @space }
        end
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: @space.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /join_spaces/1/1
  def join
    @space = Space.find(params[:id])
    @user = current_user
    respond_to do |format|
      if current_user.is_not_admin? && @space.public? && @user.set_main_space(@space.id)
        format.html { redirect_to my_space_path, success: t('spaces.join') }
        format.json { render :show, status: :ok, location: @space }
        format.js
      else
        format.html { redirect_to spaces_path, danger: 'Unknown error' }
      end
    end
  end

  # DELETE /spaces/1
  # DELETE /spaces/1.json
  def destroys
    @space.destroy
    respond_to do |format|
      format.html { redirect_to spaces_url, success: 'Space was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def search_space(space_name='')
    space_name.include?('-') ? space_name = space_name.gsub('-', '.') : space_name

    return Space.where(name: space_name).any? ? Space.where(name: space_name).first : current_space
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def space_params
    params.require(:space).permit(:user_id, :name, :cover_picture)
  end

  def update_space_params
    params.require(:space).permit(:admin_id, :name, :description, :logo, :cover_picture, :discoverable, :private)
  end
end
