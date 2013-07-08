class TcpsController < ResourceController
  include ProjectableController

  def create_project
    create_project! do |format|
      project = @tcp.create_project
      format.html { redirect_to project_path(project) }
    end
  end

end
