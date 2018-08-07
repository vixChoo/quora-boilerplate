# 20180731154000_create_user

class CreateAnswer < ActiveRecord::Migration[5.0]
    def change
        create_table :answers do |t|
             t.string :description
             t.string :title
             t.references :user,index:true
             t.references :question,index:true

             t.timestamps
      
        end
      
    end
    
end

