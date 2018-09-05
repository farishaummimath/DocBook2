class DoctorsController < ApplicationController
  filter_access_to :all, :except => [:show]
  filter_access_to :show, :attribute_check => true, :load_method => lambda {Doctor.find(params[:id])}
  def index
    @doctors = Doctor.all
  end

  def new
    @title ="Add Doctor"
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.create(params[:doctor])
    if @doctor.save
      flash[:success] = "Added Doctor"
      redirect_to doctors_path
    else
      @title = "Add Doctor"
      render 'new'
    end
  end

  def edit
     @doctor = Doctor.find(params[:id])
  end

  def update
    @doctor = Doctor.find(params[:id])
    
    if @doctor.update_attributes(params[:doctor])
      flash[:success] = "Doctor updated."
      redirect_to doctor_path
    else
      @title = "Edit Doctor"
      render 'edit'
    end
  end
  
  
  
  def show
    
     @doctor = Doctor.find(params[:id])
     @title = CGI.escapeHTML(@doctor.first_name)
  end
  
  def destroy
      @doctor = Doctor.find(params[:id])
      @doctor.destroy
      redirect_to doctors_path

  end
  

end
