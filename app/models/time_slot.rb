class TimeSlot < ActiveRecord::Base
  belongs_to :doctor
  has_many :appointments
  default_scope :order => 'start_time ASC'
  validates_presence_of :doctor_id, :start_time, :end_time

end
