class SearchesController < SpacesController
	include SpacesHelper
	before_action :set_space

  def new
    @spaces = Space.discoverables
  end

  def index
    @item_type = ["all", "space", "survey", "project", "actuality"].include?(params[:item].to_s) ? params[:item].to_s : "idea" 
    
    @q = params[:q] == "" ? "*" : params[:q].to_s

    @fullitems = []

    result = search("*")
    @result_pagy, @result = pagy_array(result, items: 12)

    @search = search(@q)
    @pagy, @items = pagy_array(@search, items: 12)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
  end
end
