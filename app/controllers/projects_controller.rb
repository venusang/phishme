class ProjectsController < ApplicationController
  before_action :set_project, :except => [:index, :new, :create]

  def index
    @projects = Project.all

    @project_by_title =  @projects.sort_by {|obj| obj.title }
    @projects_created_at = @projects.sort_by {|obj| obj.created_at }.reverse
    @projects_updated_at = @projects.sort_by {|obj| obj.updated_at }.reverse


    respond_to do |format|
      format.html
      format.json { render :json => @projects }
    end
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_path(@project),
                      :notice => 'Project was successfully created.' }
        format.json { render :json => @project }
      else
        format.html { render :action => 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_path(@project),
                      :notice => 'Project was successfully updated.' }
        format.json { render :json => @project }
      else
        format.html { render :action => 'edit' }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_path,
                    :notice => 'Project was successfully destroyed.' }
      format.json { render :json => {'notice': 'Project was sucessfully destroyed'}}
    end
  end

  def clear
    @project.items.complete.destroy_all
    respond_to do |format|
      format.html { redirect_to project_path(@project),
                    :notice => 'Completed items were successfully cleared.' }
      format.json { render :json => {'notice': 'Completed items were successfully cleared.'} }
    end
  end

private
  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title)
  end
end

