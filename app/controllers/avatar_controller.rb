class AvatarController < ApplicationController
	before_action :authenticate_user!
  def new
  end

  def create
  	@user = current_user
  	@user.avatar.attach(params[:user][:avatar])
  	respond_to do |format|
  		format.html { redirect_to edit_user_registration_path, success: "Avatar was successfully updated" }
  		format.js
  	end
  end

  def destroy
  end
end
