# 20180731154000_create_user

class CreateQuestion < ActiveRecord::Migration[5.0]
    def change
        create_table :questions do |t|
             t.string :title
             t.string :description
             t.references :user,index:true
             

             t.timestamps
      
        end
      
    end
    
end

