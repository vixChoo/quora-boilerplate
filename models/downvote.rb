require_relative '../config/init.rb'

class Downvote < ActiveRecord::Base
    belongs_to :user   
    belongs_to :question
end