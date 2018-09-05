class Bedallocation < ActiveRecord::Base

  belongs_to :room
  belongs_to :bed
  belongs_to :patient
  attr_accessible :room_id ,:bed_id ,:patient_id

  validates_presence_of :room_id ,:bed_id ,:patient_id
end
