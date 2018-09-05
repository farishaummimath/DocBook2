class PatientsController < ApplicationController
  filter_access_to :all, :except => [:show]
  filter_access_to :show, :attribute_check => true, :load_method => lambda {Patient.find(params[:id])}
  
  def index
    @patients = Patient.all
  end

  def new
    @title ="Add Patient"
    @patient = Patient.new
  end

  def create
    @patient = Patient.create(params[:patient])

    if @patient.save
      flash[:success] = "Added Patient"
      redirect_to patients_path
    else
      @title = "Add Patient"
      render 'new'
    end
  end

  def edit
     @patient = Patient.find(params[:id])
  end

  def update
    @patient = Patient.find(params[:id])
    if @patient.update_attributes(params[:patient])
      flash[:success] = "Patient updated."
      redirect_to patient_path
    else
      @title = "Edit Patient"
      render 'edit'
    end
  end

  def show
     @patient = Patient.find(params[:id])
     @title = CGI.escapeHTML(@patient.first_name)
  end

  def destroy
      @patient = Patient.find(params[:id])
      @patient.destroy
      flash[:success] = "Patient Deleted"
      redirect_to patients_path

  end
end
