authorization do
  role :admin do
     includes :manage_departments
     includes :manage_patients
     includes :manage_doctors
     includes :manage_patients    
     includes :manage_users  
     includes :manage_rooms 
     includes :manage_beds  
     includes :manage_bedallocations
     includes :manage_medicalrecords
     includes :manage_users       
     includes :manage_appointments    
  end
  role :guest do
      has_permission_on :patients, :to => [:new,:create]
  end
  role :patient do
      has_permission_on :patients, :to => [:show,:edit,:update] do
         if_attribute :user_id => is {user.id}
      end
      has_permission_on :appointments, :to => [:new,:create,:update_doctors,:update_slots,:my_appointments]
  end
  role :doctor do
      has_permission_on :doctors, :to => [:show, :edit, :update] do
         if_attribute :user_id => is {user.id}
      end
      
      has_permission_on :appointments, :to => [:my_patients]
      has_permission_on :medical_records, :to => [:index, :new, :create, :show,:show_patient_record, :update]
        

  end
  role :manage_users do
    has_permission_on :users, :to => [:index, :new, :create, :edit,:show, :update,:destroy]
  end
  role :manage_departments do
    has_permission_on :departments, :to => [:index, :new, :create, :edit,:show, :update,:destroy]
  end
  role :manage_users do
    has_permission_on :users, :to => [:index, :new, :create, :show, :update,:destroy]
  end
  role :manage_patients do
    has_permission_on :patients, :to => [:index, :new, :create, :show, :update,:destroy]
  end
  role :manage_doctors do
    has_permission_on :doctors, :to => [:index, :new, :create, :edit,:show, :update,:destroy]
  end
  role :manage_appointments do 
    has_permission_on :appointments, :to => [:index,:show,:destroy]
  end
  role :manage_rooms do 
    has_permission_on :rooms, :to => [:index, :new, :create, :edit,:show, :update,:destroy,:all_rooms,:export,:room_dashboard]
  end
  role :manage_beds do 
    has_permission_on :beds, :to => [:index, :new, :create, :edit,:show, :update,:destroy]
  end
  role :manage_bedallocations do 
    has_permission_on :bedallocations, :to => [:index,:update_beds, :new, :create, :edit,:show, :update,:destroy]
  end 
  role :manage_medicalrecords do 
    has_permission_on :medical_records, :to => [:index, :all_medical_records,:show,:destroy]
  
 end
   
end