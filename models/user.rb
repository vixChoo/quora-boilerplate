require_relative '../config/init.rb'
# require "sqlite3"
# require "active_record"
require "bcrypt"

class User < ActiveRecord::Base
    has_secure_password # => this is method authenticate must hv password_digest

    # validates :email,presence: true,uniqueness: true,:message => 'Seems like invalid ,try again!'
    validates :username,:presence => true,
              :uniqueness => true

    validates :email,:presence => true,
              :uniqueness => true

    validates :email, format: { with: /[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}/ } 
       # validates :password, length: { in: 6..20 }
    validate :password_presence, :valid_password?

    has_many :questions,dependent: :destroy  
    has_many :answers,dependent: :destroy    
    has_many :downvotes,dependent: :destroy          
    has_many :upvotes,dependent: :destroy          
    
    def password_presence
        if self.password.nil?
            errors.add(password: { message: "Cannot be blank" })
        end
    end
    
    def valid_password?
        if self.password.length < 6 
            errors.add("must be at least 6 characters and include one number and one letter.")

        end
    end
        
    # end

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
