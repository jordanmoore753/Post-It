class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post = @post
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = 'Your comment was added.'
      redirect_to post_path @post
    else
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find params[:id]
    result = Vote.create(voteable: @comment, user_id: current_user, vote: params[:vote])
    
    if result.id.nil? && !result.id.is_a?(Integer)
      flash[:error] = "You've already voted on this."
    else
      flash[:notice] = 'Vote counted.'
    end

    redirect_to :back
  end
end