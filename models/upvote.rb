require_relative '../config/init.rb'

class Upvote < ActiveRecord::Base
    belongs_to :user   
    belongs_to :question   
end


   
