class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post = @post

    @comment.creator = current_user # TODO: Fix after authentication

    if @comment.save
      flash[:notice] = "You created a new comment"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end
end