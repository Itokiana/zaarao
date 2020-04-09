module ProjectsHelper
	# Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:name, :description, :type_id, :ready, :cover_picture)
  end

  def authenticate_project
    if action_name=="show" && !@project.ready?
      redirect_to edit_project_path(id: @project.id),
      warning: t('projects.warning')
    end
    if action_name=="edit" && @project.ready?
      redirect_to project_path(id: @project.id),
      warning: "This project is neiver editable"
    end
  end

  def customized_date
    deadline = params[:project][:deadline]
    day = deadline.split("/")[1]
    month = deadline.split("/")[0]
    year = (deadline.split("/")[2]).split(' ')[0]
    time = (deadline.split("/")[2]).split(' ')[1]
    am_or_pm = (deadline.split("/")[2]).split(' ')[2]
    final_date = day+'th'+" "+month+" "+year+" "+time+" "+am_or_pm
    final_date
    final_date.to_datetime
  end
  
	def authenticate_user
    authenticate_user!
    if action_name=="edit"
      @project = set_project
      unless @project.user == current_user
        redirect_to "/404.html"
      end
    end
    if action_name != "new" && action_name != "create"
      @project = set_project
    end
  end
end
