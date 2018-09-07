require 'digest'
class User < ActiveRecord::Base
  has_one :doctor,:dependent => :destroy
  has_one :patient,:dependent => :destroy
  
  attr_accessor :password
  attr_accessible :username, :password, :user_type
  
  validates_presence_of :username,:password
  validates_uniqueness_of :username, :case_sensitive => false
  
  before_save :encrypt_password
  
  def role_symbols
    symbols = []
    if self.user_type.downcase == 'admin'
      symbols = [:admin]
    elsif self.user_type.downcase == 'doctor'   
      symbols= [:doctor]
    elsif self.user_type.downcase == 'patient'
      symbols= [:patient]
    else
        return nil
    end 
    return symbols
  end
  
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)  
  end
  
  def self.authenticate(username, submitted_password)
    
  	user = User.find_by_username(username)
    if submitted_password.present?
      if (user && user.has_password?(submitted_password))
        return user
      else
        return nil
      end
    end
      
  end
  
  private
  
		def encrypt_password
      self.salt = make_salt  if new_record?

      self.encrypted_password = encrypt(password)
        
      
		end

		def encrypt(string)
			secure_hash("#{salt}#string") # temp implementation
		end

		def make_salt
			secure_hash("#{Time.now.utc}#{password}")
		end

		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end
end
