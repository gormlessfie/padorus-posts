class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = 'Post successful.'
      redirect_to root_path
    else
      flash[:error] = 'Post unsuccessful.'
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
