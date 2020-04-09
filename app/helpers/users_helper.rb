module UsersHelper
	def user_update_params
		user_params = params.require(:user).permit(:firstname, :lastname, :language_id)
	end

	def authenticate_user
    authenticate_user!
    if current_user.uncomplete?
      redirect_to edit_user_registration_path,
      warning: t('idea.valide.completed')
    end
  end

  def authenticate_admin
    authenticate_user
    unless (current_user.admin? && current_space == current_user.main_space) || current_user.super_admin?
      redirect_to "/404.html"
    end
  end

  def authenticate_admin!
    authenticate_admin
  end

  def update_user_space(user, space)
    old_spaces = user.visited_spaces

    user.visited_spaces = [space]

    user.visited_spaces += (old_spaces)

    user.visited_spaces = user.visited_spaces.uniq
  end
end
