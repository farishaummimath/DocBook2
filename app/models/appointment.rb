class Appointment < ActiveRecord::Base
  attr_accessible :appointment_date, :department_id, :doctor_id, :time_slot_id
  belongs_to :department
  belongs_to :doctor
  belongs_to :patient
  belongs_to :time_slot
  default_scope :order => 'created_at DESC'

  validates_presence_of :appointment_date, :department_id, :doctor_id, :time_slot
end
