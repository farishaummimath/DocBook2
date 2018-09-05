class MedicalRecordsController < ApplicationController
  filter_access_to :all
  def index
    @medical_records = MedicalRecord.all(:conditions => ['doctor_id = ?',current_user.doctor.id])
    @doctor=current_user.doctor
    puts "DOCTOR++++++#{@doctor.inspect}"
    @mypatients=@doctor.patients
  end
  
  def all_medical_records
    @medical_records = MedicalRecord.all
    
  end
  
  def new
    @title ="Add MedicalRecord"
    @doctor = current_user.doctor
    @mypatients=@doctor.patients
    puts "DOCTOR++++++#{@mypatients.inspect}"
    @medicalrecord = MedicalRecord.new()
   
      #   puts "---------------------#{params[:patient_id].inspect}"

  end
  
  def my_medical_records
    @patient=current_user.patient
    @mymedicalrecords=@patient.medical_records
    if @mypatients.nil?
      puts "SOMEEEEEEEEEEEEEEEEEEEEEEEEE"
      
    end
  end
  def my_medical_record_pdf
      @patient=current_user.patient
      @patient_records=@patient.medical_records.all(:conditions => ['id = ?',params[:id]])
        render :pdf => "medical_record_pdf.html",
              :template => "medical_records/medical_record_pdf"
               
  end
  
  def show_patient_record
       @patient = Patient.find(params[:patient_id])
       @patient_records=@patient.medical_records.all(:conditions =>['doctor_id = ?',current_user.doctor.id])

  end
  def medical_record_pdf
       @patient = Patient.find(params[:patient_id])
       @patient_records=@patient.medical_records.all(:conditions =>['doctor_id = ? AND id =?',current_user.doctor.id,params[:id]])
        puts "............RECORDs #{@patient_records.inspect}"
        render :pdf => "medical_record_pdf.html",
              :template => "medical_records/medical_record_pdf"
               
  end
  def create
    @medicalrecord = MedicalRecord.create(params[:medical_record])
    @doctor = current_user.doctor
    @mypatients=@doctor.patients
#   @medicalrecord.doctor = current_user.doctor
    if @medical_record.save
      flash[:success] = "Medical Record Added."
      redirect_to medical_records_path
    else
      render 'new'
    end 
  end
  
  def show
   @medical_record = MedicalRecord.find(params[:id])
  end

  def edit
     @medical_record = MedicalRecord.find(params[:id])
  end

  def update
    @medical_record = MedicalRecord.find(params[:id])
    if @medical_record.update_attributes(params[:medical_record])
      flash[:success] = "Medical Record updated."
      redirect_to medical_records_path
    else
      @title = "Edit medical_records"
      render 'edit'
    end
  end

  def show
     @medical_record = MedicalRecord.find(params[:id])
    # @title = CGI.escapeHTML(@medical_record.name)
  end

  def destroy
      @medical_record = MedicalRecord.find(params[:id])
      @medical_record.destroy
      redirect_to medical_records_path
  end

end
