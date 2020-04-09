class PagesController < ApplicationController
	before_action :authenticate_user
	def home
	end

	private
	def authenticate_user
		if user_signed_in?
			redirect_to my_space_path
		end
	end
end
