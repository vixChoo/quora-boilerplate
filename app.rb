# require_relative './config/init.rb'
# set :run, true

# get '/' do
#   @name = "Bob Smith"
#   erb :"home"
# end

require_relative './config/init.rb'
set :run, true

get '/' do #means in the main page 
  @name = "Vixtrum"
  @greeting = "Hi Welcome SEAN , My favourite Teacher & Master "
  @date = Time.now.strftime("%H:%M %d/%m/%Y ")
  erb :"home" #represent u html home file 

end

get '/signup' do #get to show the page
    erb :"signup" 
end

# get '/login' do #get to show the page
#     erb :"login" 
#   end
  
  post '/signup' do
    user = User.new(params[:user])
    # @welcome = "Hi! Welcome to bullshit something here!"
    if user.save
      redirect "/"
      # what should happen if the user is saved?
    else
      erb :"signup"
      # what should happen if the user keyed in invalid date?
    end
    
    # post '/login' do
    #   user = User.find_by_email(params[:email])
    #   if user.password == params[:password]
    #     redirect "/"
    #   else
    #     erb :"login" 
    #     # errors.add(email: { message: "Try again" })
    #   end

end
#get is get something from database
#post is edit and store into database
  #  get '/students' do
  #    @students = Student.all # query for all students in db
  #    erb :"students/index" # render students/index.erb
  #  end