require 'byebug'
set :run, true
enable :sessions
after { ActiveRecord::Base.connection.close }  
#to make the connection fixed


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
      @question.title = params[:question][:title] if params[:question][:title] != ""
      @question.description = params[:question][:description] if params[:question][:description] != ""
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
      @answer.title = params[:title] if params[:answer][:title] != ""
      @answer.description = params[:description]  if params[:answer][:description] != ""
      @answer.save
      erb :"question"
      
    end
    
    post"/question/:id/upvote/new" do
      Upvote.create(user_id: session[:user_id], question_id: params[:id])
   
    end
    
    post"/question/:id/downvote/new" do
      Downvote.create(user_id: session[:user_id], question_id: params[:id])
       redirect "/"
    end
        
        
      post"/question/:id/upvote/delete" do 
        @upvote = Upvote.find_by(question_id: params[:id], user_id: current_user.id)
        @upvote.delete
       redirect "/"
      end

    post"/question/:id/downvote/delete" do 
       @downvote = Downvote.find_by(question_id: params[:id], user_id: current_user.id)
       @downvote.delete
        redirect "/"
     end
    