module ApplicationHelper
	include Pagy::Frontend
	
	def add_viewer(user_id=0, project_id=0, idea_id=0, survey_id=0, call_for_idea_id=0, actuality_id=0)
		@user = User.find(user_id)
		if project_id > 0
			project = Project.find(project_id)
			if project && project.viewers.where(user_id: @user.id).any?
				viewer = Viewer.find_by(user: @user, wys_id: project_id, project: true)
			else
				viewer = Viewer.new(user: @user, wys_id: project_id, project: true)
			end
			user_viewed(viewer)
		elsif idea_id > 0
			idea = Idea.find(idea_id)
			if idea && idea.viewers.where(user_id: @user.id).any?
				viewer = Viewer.find_by(user: @user, wys_id: idea_id, idea: true)
			else
				viewer = Viewer.new(user: @user, wys_id: idea_id, idea: true)
			end
		elsif survey_id > 0
			survey = Survey.find(survey_id)
			if survey && survey.viewers.where(user_id: @user.id).any?
				viewer = Viewer.find_by(user: @user, wys_id: survey_id, survey: true)
			else
				viewer = Viewer.new(user: @user, wys_id: survey_id, survey: true)
			end
		elsif call_for_idea_id > 0
			call_for_idea = CallForIdea.find(call_for_idea_id)
			if call_for_idea && call_for_idea.viewers.where(user_id: @user.id).any?
				viewer = Viewer.find_by(user: @user, wys_id: call_for_idea_id, call_for_idea: true)
			else
				viewer = Viewer.new(user: @user, wys_id: call_for_idea_id, call_for_idea: true)
			end
		elsif actuality_id > 0
			actuality = Actuality.find(actuality_id)
			if actuality && actuality.viewers.where(user_id: @user.id).any?
				viewer = Viewer.find_by(user: @user, wys_id: actuality_id, actuality: true)
			else
				viewer = Viewer.new(user: @user, wys_id: actuality_id, actuality: true)
			end
		end

		user_viewed(viewer)
	end

	def user_viewed(viewer)
		if viewer.save
			respond_to do |format|
				format.html
				format.js
			end
		else
			respond_to do |format|
				format.html{ redirect_to my_space_path, danger: viewer.errors.full_messages}
			end
		end
	end

	def default_space
		Space.first
	end

	def current_space
		user_signed_in? ? current_user.main_space : default_space
	end

	def count(number)
		number_to_human(number, units: {thousand: "k", million: "M"})
	end

	def page_need_mdb_pro
		if true# action_name=="show" || action_name=="edit"
		 return true
		else
			return false
		end
	end

	def default_cover_picture_url
		'/assets/default-cover-picture.png'
	end

	def reindex_all
		Space.reindex
		Survey.reindex
		Idea.reindex
		Project.reindex
		Actuality.reindex
	end

	def dl
		return I18n.locale
	end
end
