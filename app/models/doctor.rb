class Doctor < ActiveRecord::Base
  belongs_to :user
  belongs_to :department
  
  has_many :appointments
  has_many :time_slots
  has_many :patients, :through => :appointments
  has_many :medical_records
  
  attr_accessible :first_name, :last_name ,:email,:contact_number,:nationality,:qualifications,:experience,:date_of_birth,:department_id,:gender
  
  
  EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates_presence_of :first_name, :last_name, :email,:date_of_birth,:department_id,:gender
  validates_numericality_of :contact_number, :only_integer => true
  validates_format_of	  :email, :with => EmailRegex
  validates_uniqueness_of :email, :case_sensitive => false
  
  before_create :add_user
  #before_update :update_user

  def add_user
    user = User.new
    user.username = self.first_name + self.last_name
    user.password = self.first_name + self.last_name+"123"
    user.user_type = "Doctor"
    user.save
    self.user = user unless user.new_record? 
  end
 
  def update_user
    puts "Some thing working"
   # user.username = self.first_name + self.last_name
    #user.save  
   end
  
end
