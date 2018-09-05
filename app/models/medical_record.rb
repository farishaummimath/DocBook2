class MedicalRecord < ActiveRecord::Base
  belongs_to :patient
  belongs_to :doctor
  attr_accessible :patient_id, :doctor_id, :patient_condition,:comments, :medication_given,:document
  has_attached_file :document

	validates_attachment_content_type :document, :content_type => ['application/pdf']
  validates_presence_of :patient_id, :doctor_id, :patient_condition
  
end