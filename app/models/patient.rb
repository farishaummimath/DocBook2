class Patient < ActiveRecord::Base
  belongs_to :user
  belongs_to :department
  has_many :appointments
  has_many :doctors, :through => :appointments
  has_many :medical_records
  has_one :bed_allocation
  attr_accessible :first_name, :last_name , :email,:contact_number,:nationality,:date_of_birth,:blood_group,:gender,:photo
  
  default_scope :order => 'first_name ASC'
  
  has_attached_file :photo, :styles => {:medium => "120x120>", :thumb => "20x20>"},
					   :default_url =>'/images/missing_thumb.png'

	validates_attachment_content_type :photo, :content_type => ['image/jpeg','image/png']
  
  EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i  
  validates_presence_of :first_name, :last_name, :date_of_birth, :email,:gender,:blood_group
  validates_numericality_of :contact_number, :only_integer => true
  validates_format_of	  :email, :with => EmailRegex
  validates_uniqueness_of :email, :case_sensitive => false
  #validate :unique_email
  
  before_create :add_user
  
  def add_user
    user = User.new
    user.username = self.first_name + self.last_name
    user.password = self.first_name + self.last_name+"123"
    user.user_type = "Patient"
    user.save
    self.user = user unless user.new_record? 
  end
end
