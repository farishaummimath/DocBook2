class Department < ActiveRecord::Base
  has_many :doctors, :dependent => :destroy
  has_many :appointments

  attr_accessible :name, :about
  
end
