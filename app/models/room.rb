class Room < ActiveRecord::Base
  attr_accessible :room_number, :room_details
  has_many :beds, :dependent => :destroy
  has_many :bedallocations
  default_scope :order => 'room_number ASC'
  validates_presence_of :room_number, :room_details

  validates_uniqueness_of :room_number, :case_sensitive => false
  
  def self.find_beds
   #find_by_sql("select rooms.room_number,rooms.room_details,count(beds.bed_number) as bed_count from rooms left join beds on rooms.id = beds.room_id group by rooms.room_number")
   find_by_sql("select rooms.room_number,rooms.room_details,
count(beds.bed_number)as total_beds,
 case 
when count(beds.bed_number) = 0 THEN 0.00
else format(((count(bedallocations.bed_id)) * 100)/count(beds.bed_number),2) end as occupied_beds,
case
when  count(beds.bed_number) = 0 THEN 0.00
else format(((count(beds.bed_number)-count(bedallocations.id))*100)/count(beds.bed_number),2) end as available_beds 
from beds 
left join bedallocations 
on beds.id = bedallocations.bed_id 
right join rooms 
on beds.room_id = rooms.id 
group by rooms.room_number")
  end
    
end
