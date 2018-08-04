    # require_relative './config/init.rb'
    # set :run, true

    # get '/' do
    #   @name = "Bob Smith"
    #   erb :"home"

require 'byebug'
require_relative './config/init.rb'
set :run, true
enable :sessions
after { ActiveRecord::Base.connection.close }  
#to make the connection fixed


    get '/' do #means in the main page 
      if logged_in?
        @user = current_user
        @greeting = "Hi welcome #{@user.username}"
      else
        redirect "/login"
        erb :"login"
      end
      @date = Time.now.strftime("%H:%M %d/%m/%Y")
      @names = User.all # will show u all the user things but username is never had had key in before
      @ask = Question.all
      erb :"home" #represent u html home file 
    end
    
    
    
    get '/signup' do #get to show the page
      if !current_user
         erb :"signup"
        else log_out
          redirect '/login'
        end #try in post , effectlessly
     end
    
    post '/signup' do
      user = User.new(params[:user])
     #User.create(email:"params[email]",password:"params[password]")
    if user.save
        session[:user_id] = user.id
        @user = current_user
        redirect "/profile/#{user.id}"
        # what should happen if the user is saved?
            
      else
        @errors_signup = "Try another one"
        
        # what should happen if the user keyed in invalid date?
      end
      
    end
    
    get '/login' do #get to show the page
      erb :"login" 
    end
    
    post '/login' do
      user = User.find_by_email(params[:user][:email])
      # params = { user: {password: "asdasd"}} see the form is --> user[password]
      if user && user.authenticate(params[:user][:password])
        # above meaning if the user exist  && if the user password correct pass it down
        # Save the user id inside the browser cookie. This is how we keep the user 
        # logged in when they navigate around our website.
        session[:user_id] = user.id
        @current_user = user
        redirect "/profile/#{user.id}"

      elsif logged_in?
           redirect "/profile/#{user.id}"
      else
        erb :"/login"
      end
    end

    get '/logout' do
      session[:user_id] = nil
      redirect '/login'
      
    end
    
    
    get '/question/:id' do
       @question = Question.find(params[:id])
       @answers = @question.answers
      @user = User.find_by(params[:question_id])
      
        if current_user
        erb :"question"
      else
        redirect "/question/#{@question.id}"
      end
    end
    
    post "/question" do
      # => params[:id] returns the value input in the :wildcard path, aka 20
      # user = User.find_by(username: params[:id])
      question = current_user.questions.new(params[:question])
      if question.save
        @question = question
        redirect "/question/#{@question.id}"
      else
        redirect "/"
      end
    end
    
    delete '/question/:id/delete' do #delete action
      @question = Question.find_by_id(params[:id])
      @question.delete
      redirect "/"
      end

     patch '/question/:id/edit' do #edit action
      @question = Question.find_by_id(params[:id])
      @question.title = params[:title]
      @question.description = params[:description]
      @question.save
      redirect "/question/#{@question.id}"
    end
    
    get '/question/answer/:id' do
      @answer = Answer.find_by_id(params[:id])
      erb :"question"
    end
    
    
    post "/answer" do
      # => params[:id] returns the value input in the :wildcard path, aka 20
      # user = User.find_by(username: params[:id])
      @answer = Answer.new(params[:answer])
    
      if @answer.save
        redirect "/question/#{@answer.question_id}"
      else 
        redirect "/"
      end
    end
    
    delete '/question/answer/:id/delete' do #delete action
      @answer = Answer.find_by_id(params[:id])
      @answer.delete
      
    end
    
    patch '/answer/:id/edit' do #edit action
      @answer = Answer.find_by_id(params[:id])
      @answer.title = params[:title]
      @answer.description = params[:description]
      @answer.save
      erb :"question"
      
    end
    
    post"/question/:id/upvote" do
      Upvote.create(user_id: session[:user_id], question_id: params[:id])
      redirect "/"
    end
    
    post"/question/:id/downvote" do
      Downvote.create(user_id: session[:user_id], question_id: params[:id])
      redirect "/"  
    end
        
        
       post"/question/:id/upvote/delete" do 
        @upvote = Upvote.find_by_id(params[:id])
        @upvote.delete
        
      end

      post"/question/:id/downvote/delete" do 
       @downvote = Downvote.find_by_id(params[:id])
       @downvote.delete
       
     end
      # get "/question/:id/vote" do

    #   @vote = QuestionVote.find_by(user_id: session[:user_id], question_id: params[:id])
    #   if @vote.nil?
    #     @vote = QuestionVote.new(user_id: session[:user_id], question_id: params[:id])     
    #     redirect back
    #   else
    #     @vote.like +=1
    #     redirect back
    #   end

    #     end

    # get '/votes/up_vote/:id' do
    #   vote_to_add = Question_vote.new(user_id: session[:user_id], question_id: params[:id])
    #   vote_to_add.save
    #   redirect "/"
    # end   
  

     delete '/user/:id/delete' do #delete action
      @user = User.find_by_id(params[:id])
      @user.delete
      redirect "/"
      end
      
      get '/profile/:id' do
         @user = User.find(params[:id])
         @ask = @user.questions
        erb :"profile"
        
        # some code here to find the user with the id given and render the profile page containing the user's infomation
      end
      
      
      post '/profile' do
         @user = User.find( params[:id])
         @ask = @user.questions
         if @user.id != current_user.id
          redirect "/profile/#{@user.username}"
        else
          erb :"profile"
        end
        
        # some code here to find the user with the id given and render the profile page containing the user's infomation
      end
      
      
      
      
      
      
      #get is get something from database
      #post is edit and store into database

      #  get '/students' do
      #    @students = Student.all # query for all students in db
      #    erb :"students/index" # render students/index.erb
      #  end