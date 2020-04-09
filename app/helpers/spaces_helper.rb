module SpacesHelper
  include Pagy::Frontend
  include ApplicationHelper
  
  def set_space
    @space = current_space
    @unready_ideas = @space.ideas.where(ready: false)
    @ready_ideas = @space.ideas.where(ready: true)
  end

  def default_space
    Space.first
  end

  def current_space
    user_signed_in? ? current_user.main_space : default_space
  end
end
