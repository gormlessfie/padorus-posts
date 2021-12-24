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

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to user_post_path(@post.user.id, @post), notice:'Post updated successfully'
    else
      flash.now[:error] = 'Something went wrong'
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
