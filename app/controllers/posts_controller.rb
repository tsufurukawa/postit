class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]
  before_action :require_user, except: [:show, :index]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user #TODO: change once we have authentication

    if @post.save
      flash[:notice] = "You successfully created a new post"
      redirect_to posts_path
    else
      render :new 
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = "You successfully updated your post"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  private 

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: []) 
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
