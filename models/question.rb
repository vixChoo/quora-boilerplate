require_relative '../config/init.rb'

class Question < ActiveRecord::Base
    belongs_to :user   
    has_many :answers,dependent: :destroy        
    has_many :upvotes,dependent: :destroy   
    has_many :downvotes,dependent: :destroy          
end


   
