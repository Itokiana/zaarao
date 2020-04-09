class Actualities::LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_actuality

  def create
    @actuality.likes.where(user_id: current_user.id).first_or_create
    respond_to do |format|
      format.html { redirect_to @actuality }
      format.js
    end
  end

  def destroy
    @actuality.likes.where(user_id: current_user.id).destroy_all
    respond_to do |format|
      format.html { redirect_to @actuality }
      format.js
    end
  end
  private
    def set_actuality
      @actuality = Actuality.find(params[:actuality_id])
    end
end
