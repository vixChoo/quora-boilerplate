# 20180731154000_create_user

class CreateUpvotes < ActiveRecord::Migration[5.0]
    def change
        create_table :upvotes do |t|
             t.references :user,index:true
             t.references :question,index:true
             t.timestamps
             
     
        end
    end
    
end

