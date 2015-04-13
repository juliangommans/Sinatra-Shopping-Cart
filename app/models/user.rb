require 'set'

class User < ActiveRecord::Base
	validates :user_name, uniqueness: true
	validates :user_name, presence: true
	validates :user_password, length: { in: 6..18 }
	validates :user_password, format: { with: /([A-Z])/, message: "must contain at least one capitol letter" }
	validates :user_password, format: { with: /([0-9])/, message: "must contain at least one number" }
	
	def self.authenticate(name,password)
		authentication = User.find_by(user_name: name)
    unless authentication.nil?
      if password == authentication.user_password
        return authentication
      else
        return nil
      end
    end
	end



end
