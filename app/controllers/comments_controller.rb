class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post = @post

    @comment.creator = User.first # TODO: Fix after authentication

    if @comment.save
      flash[:notice] = "You created a new comment"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end
end