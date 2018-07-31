require_relative '../config/init.rb'
# require "sqlite3"
# require "active_record"
require "bcrypt"

class User < ActiveRecord::Base
    has_secure_password

    # validates :email,presence: true,uniqueness: true,:message => 'Seems like invalid ,try again!'
    validates :email,:presence => true,
              :uniqueness => true
          
    # validates :password, length: { in: 6..20 }
    validate :password_presence 

    def password_presence
        if self.password.nil?
            errors.add(password: { message: "Cannot be blank" })
        end

    # def password_unique
    #   if self.password.exclude?()
            
    #     else
    #         errors.add(password: { message: "Try another one " })
    #     end
    # end
  
               

end


   
# def self.authenticate(username_or_email="", login_password="")
#             if  EMAIL_REGEX.match(username_or_email)    
#                 user = User.find_by_email(username_or_email)
#             else
#                 user = User.find_by_username(username_or_email)
#             end
#             if user && user.match_password(login_password)
#                 return user
#             else
#                 return false
#             end
#             end   
#             def match_password(login_password="")
#             encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
#             end
# end  
# def login
#   @user = User.find_by_email(params[:email])
#   if @user.password == params[:password]
#     give_token
#   else
#     redirect_to home_url
#   end
