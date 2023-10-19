class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, except: [:index, :show]
  http_basic_authenticate_with name: "username", password: "password", except: [:index, :show]

  def index
    @posts = Post.all
  end
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def show
    set_post
  end

  def edit
    set_post
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end
  

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end
  

  private

  def set_post
    @post = Post.find(params[:id])
  end
  
  def post_params
    params.require(:post).permit(:title, :body) # Add any other attributes that need to be permitted
  end

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      if username == "username" && password == "password"
        session[:authenticated] = true
      else
        session[:authenticated] = false
      end
    end
  end

  def authenticated?
    session[:authenticated]
  end
  helper_method :authenticated?
end
	
