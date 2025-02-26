class SessionsController < ApplicationController
  def login
  end
  def new
    
  end
  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to posts_url
    else
      @last_email = params[:session][:email]
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
  
end
