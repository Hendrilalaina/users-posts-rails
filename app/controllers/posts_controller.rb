class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :same_user, only: [:edit, :destroy, :update]

  def show
    
  end
  
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user = User.find(session[:user_id])
    if @post.save
      redirect_to post_url(@post), notice: "New post!"
    else
      render :new
    end
  end

  def edit
    
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post was successfully updated"
      redirect_to @post
    else
      render :edit
    end
  end
  
  def destroy
    if @post.destroy
      flash[:success] = 'Object was successfully deleted.'
      redirect_to posts_url
    else
      flash[:error] = 'Something went wrong'
      redirect_to posts_url
    end
  end
  
  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :description)
    end

    def require_user
      user = User.find(session[:user_id])
      user
    rescue ActiveRecord::RecordNotFound
      redirect_to login_url, notice: "You must login!"
    end

    def same_user
      user = User.find(session[:user_id])
      if user.id != @post.user.id
        redirect_to posts_url, notice: "This post is not yours!"
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to login_url, notice: "You must login!"
    end

end
