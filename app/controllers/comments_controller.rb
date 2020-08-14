class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post = @post
    @comment.creator = User.first # TODO: FIX WITH AUTH USER

    if @comment.save
      flash[:notice] = 'Your comment was added.'
      redirect_to post_path @post
    else
      render 'posts/show'
    end
  end
end