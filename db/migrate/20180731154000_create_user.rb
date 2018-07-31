# 20180731154000_create_user

class CreateUser < ActiveRecord::Migration[5.0]
    def change
        create_table :users do |t|
            t.string :username
            t.string :email
            t.string :password_digest  
            t.timestamp :confirmed_at

        end
        add_reference :users, :question, index: true
        add_reference :users, :answer, index: true

    end
    
end

# def change  
# create_table :users do |t|  
# t.string, :email  
# t.string :username  
#       t.string :email  
#       t.string :crypted_password  
#       t.string :password_salt  
#       t.string :persistence_token