class Bed < ActiveRecord::Base
  belongs_to :room
  validates_uniqueness_of :bed_number, :case_sensitive => false, :scope => :room_id

  
end
