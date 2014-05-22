class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:show, :index, :vote]
  before_action :require_same_user, only: [:edit, :update]

  def index
    @posts = Post.all.sort_by{ |x| x.total_votes }.reverse
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user 

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

  def vote
    vote = Vote.create(vote: params[:vote], creator: current_user, voteable: @post)

    if vote.valid?
      flash[:notice] = "You voted!!"
    else
      flash[:error] = "You can only vote on a post once."
    end
    
    redirect_to :back
  end

  private 

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: []) 
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def require_same_user
    if current_user != @post.creator
      flash[:error] = "You 're not allowed to do that."
      redirect_to root_path
    end
  end
end
