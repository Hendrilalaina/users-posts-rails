class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def show 
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def index
    @users = User.all
  end

  def update
    password = params["user"]["password"].to_s
    password2 = params["user"]["confirm_password"].to_s
    @user = User.find(params[:id])
    puts password, password2
    if password != password2 || password.blank? || password2.blank?
      @user.password = nil
      note = "Password not matched!"
    end
    print @user.password, "The password"
    if @user.update(user_params)
      redirect_to posts_url, notice: "Welcome #{@user.username}"
    else
      flash[:notice] = "Password not matched!"
      render :edit
    end
  end
  
  def create
    password = params["user"]["password"].to_s
    password2 = params["user"]["confirm_password"].to_s
    @user = User.new(user_params)
    puts password, password2
    if password != password2 || password.blank? || password2.blank?
      @user.password = nil
      note = "Password not matched!"
    end
    print @user.password, "The password"
    if @user.save
      redirect_to posts_url, notice: "Welcome #{@user.username}"
    else
      flash[:notice] = "Password not matched!"
      render :new
    end
  end
  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password)
  end
  
end
