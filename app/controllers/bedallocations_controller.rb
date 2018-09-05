class BedallocationsController < ApplicationController
  filter_access_to :all

  def index
    @bedallocations=Bedallocation.all
    @rooms = Room.all

  end

  def new
    @rooms = Room.all
    @bedallocation=Bedallocation.new
    @patients = Patient.all(:joins =>['LEFT OUTER JOIN bedallocations ON patients.id = bedallocations.patient_id'], :conditions => ['bedallocations.patient_id is ?',nil])
    #@slots = TimeSlot.all(:joins =>['LEFT OUTER JOIN appointments ON appointments.time_slot_id = time_slots.id AND appointments.appointment_date = ',"'#{params[:date]}'"], :conditions =>['appointments.time_slot_id IS ? AND time_slots.doctor_id = ?',nil, params[:id]])

    #select p.id,p.first_name from patients p left join bedallocations ba on p.id = ba.patient_id where ba.patient_id is null;
    @beds=[]
  end

  def create
    @bedallocation = Bedallocation.create(params[:bedallocation])
    @rooms = Room.all
    @patients = Patient.all(:joins =>['LEFT OUTER JOIN bedallocations ON patients.id = bedallocations.patient_id'], :conditions => ['bedallocations.patient_id is ?',nil])

    @beds=[]

    if @bedallocation.save
      flash[:success] = "Bed Allocated "
      redirect_to bedallocations_path
    else
      @title = "Allocate Bed"
      render 'new'
    end
  end

  def edit
   @bedallocation = Bedallocation.find(params[:id])
   @bedallocation=Bedallocation.new
    @rooms = Room.all
    @patients = Patient.all
    @beds=[]
  end
  

  def show
  end

  def update
    @bedallocation = Bedallocation.find(params[:id])
    if @bedallocation.update_attributes(params[:bedallocation])
      flash[:success] = "Allocation updated."
      redirect_to bedallocations_path
    else
      @title = "Edit allocation"
      render 'edit'
    end
  end
  def update_beds
      @beds=[]
      puts "SOMEEEEEEEEEEEEEEEEEEEEEEEEE"
      puts "=================#{params[:id].inspect}"
      if params[:id].present?
        puts "coming inside=================="
        @beds=Bed.all(:joins => ['LEFT OUTER JOIN bedallocations on beds.id = bedallocations.bed_id and bedallocations.room_id =',"'#{params[:id]}'"],:conditions =>['bedallocations.bed_id is ? AND beds.room_id = ?',nil, params[:id]])
#        select b.id,b.bed_number,b.room_id from beds b left join bedallocations ba on b.id = ba.bed_id and ba.room_id = 2 where ba.bed_id is null and b.room_id = 2;
      end
      render :update do |page|
        page.replace_html 'beds_list', :partial => 'beds_list'           
      end
  end  
  

  def destroy
     @bedallocation = Bedallocation.find(params[:id])
     @bedallocation.destroy
      redirect_to bedallocations_path
  end

end
