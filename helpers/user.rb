helpers do

  def current_user
      if session[:user_id]
        @current_user ||= User.find_by_id(session[:user_id])
      end
  end

  # Returns true if current_user exists, false otherwise
  def logged_in?
    !current_user.nil?
  end

  # a convenient method to set the session to given user's id with the `:user_id` key
  def sign_in(user)
    session[:user_id] = user.id
  end

  # clears the session by setting the value of `:user_id` key to `nil`
  def log_out
    session[:user_id] = nil
  end

  # def checkpwd[:password]
  #   user.valid_password?(params[:user][:password])
  # end
end
  
#can use in app.rb
