class SessionsController < ApplicationController
  def new
    @title ="Sign In"
  end

  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      if user.user_type.downcase == 'doctor'
        flash[:success] = "Welcome Doctor, you are Logged in!"
      elsif user.user_type.downcase == 'patient'  
          flash[:success] = "Welcome , you are Logged in!"
      else 
       flash[:success] = "Welcome Admin , you are Logged in!"

      end 
      redirect_to root_url

    else
      flash.now[:error] = "Invalid email or password"
      render "new"
    end
     
  end

  def destroy
    
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

end
