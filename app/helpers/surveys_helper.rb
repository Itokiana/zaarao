module SurveysHelper
	def current_survey
		if session[:survey_id] != params[:id]
			session[:survey_id] = params[:id]
		end

		Survey.find(session[:survey_id])
	end

	def you_are_in_this(survey)
		survey.questions.each do |question|
			question.options.each do |option|
				return true if option.users.include?(current_user)
			end
		end
		return false
	end
end
