class AppointmentsController < ApplicationController

# filter_resource_access
  filter_access_to :all
  def index
    @appointments = Appointment.all
    @departments = Department.all
    #@doctors = Doctor.all
  end

  def new
    @appointment = Appointment.new()
    @departments = Department.all
    @doctors=[]
    @slots=[]
    
  end

  def create
     @appointment = Appointment.create(params[:appointment])
     @doctors=[]
     @slots=[]


     #@doctors = Doctor.find_all_by_department_id(params[:department_id]).sort_by{ |k| k['name'] }    
      #respond_to do |format|
      #  format.json  { render :json => @doctors }      
      #end
     @appointment.patient = current_user.patient

    if @appointment.save
      flash[:success] = "Added Appointment"
      redirect_to root_path
    else  
      @title = "Add Appointment"
      render 'new'
    end
  end
  def show
    @appointment = Appointment.find(params[:id])
  end
  
  def my_patients
    @doctor=current_user.doctor
    @mypatients=@doctor.patients
    if @mypatients.nil?
      puts "SOMEEEEEEEEEEEEEEEEEEEEEEEEE"
      
    end
  end
  
  def my_appointments
    @patient=current_user.patient
    @myappointments=@patient.appointments
    if @mypatients.nil?
      puts "SOMEEEEEEEEEEEEEEEEEEEEEEEEE"
      
    end
  end
  
  def update_doctors
      @doctors=[]
      @slots =[]

      puts "SOMEEEEEEEEEEEEEEEEEEEEEEEEE"
      puts "=================#{params[:id].inspect}"
      if params[:id].present?
        puts "coming inside=================="
        @doctors=Department.find_by_id(params[:id]).doctors     
      end
      render :update do |page|
        page.replace_html 'doctors_list', :partial => 'doctors_list'           
      end
  end
  def update_slots
      @slots=[]
      puts "SOMEEEEEEEEEEEEEEEEEEEEEEEEE"
      puts "=================#{params[:id].inspect}"
      puts "=================#{params[:date]}"

      if params[:id].present? && params[:date].present?
        d = params[:date]
        puts "coming inside slots=================="
       # @slots=Doctor.find_by_id(params[:id]).time_slots 
       @slots = TimeSlot.all(:joins =>['LEFT OUTER JOIN appointments ON appointments.time_slot_id = time_slots.id AND appointments.appointment_date = ',"'#{params[:date]}'"], :conditions =>['appointments.time_slot_id IS ? AND time_slots.doctor_id = ?',nil, params[:id]])
      end
      render :update do |page|
        page.replace_html 'slot_list', :partial => 'slot_list'           
      end
  end
  
  def destroy
      @appointment = Appointment.find(params[:id])
      @appointment.destroy
      redirect_to appointments_path
  end
    
end
