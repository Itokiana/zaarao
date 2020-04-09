class VotesController < ApplicationController
	before_action :authenticate_user!, :set_item

  def create
    if @item.get_upvotes(voter: current_user, vote_scope: @vote_type).any?
      @item.unvote_by current_user, vote_scope: @vote_type
    else
      @item.vote_by voter: current_user, vote_scope: @vote_type
    end
  	respond_to do |format|
  		format.js
  	end
  end

  def destroy
    if @item.get_downvotes(voter: current_user, vote_scope: @vote_type).any?
      @item.undisliked_by current_user, vote_scope: @vote_type
    else
      @item.dislike_by current_user, vote_scope: @vote_type
    end
  	respond_to do |format|
  		format.js
  	end
  end

  protected
    def set_item
      @vote_type = params[:vote_type]
      @short = params[:short]
      @item_type = params[:item_type]
      @first_content = params[:first_content]
      @second_content = params[:second_content]
      @vote_weight = params[:vote_weight]
      @color = params[:color]

      if @item_type == "idea"
        @item = Idea.find(params[:item_id])
      elsif @item_type == "comment"
        @item = Comment.find(params[:item_id])
      elsif @item_type == "survey"
        @item = Survey.find(params[:item_id])
      elsif @item_type == "project"
        @item = Project.find(params[:item_id])
      elsif @item_type == "call_for_idea"
        @item = CallForIdea.find(params[:item_id])
      elsif @item_type == "actuality"
        @item = Actuality.find(params[:item_id])
      end
    end
end
