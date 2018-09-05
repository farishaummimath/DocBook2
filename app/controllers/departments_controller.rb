class DepartmentsController < ApplicationController
  filter_resource_access
  def index
    @departments = Department.all
  end

  def new
    @title ="Add Department"
    @department = Department.new
  end

  def create
     @department = Department.create(params[:department])

    if @department.save
      flash[:success] = "Added Department"
      redirect_to departments_path
    else
      @title = "Add Department"
      render 'new'
    end
  end

  def edit
     @department = Department.find(params[:id])
  end

  def update
    @department = Department.find(params[:id])
    if @department.update_attributes(params[:department])
      flash[:success] = "Department updated."
      redirect_to departments_path
    else
      @title = "Edit Department"
      render 'edit'
    end
  end

  def show
     @department = Department.find(params[:id])
     @title = CGI.escapeHTML(@department.name)
  end

  def destroy
      @department = Department.find(params[:id])
      @department.destroy
      redirect_to departments_path
  end

end
