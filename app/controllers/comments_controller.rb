class CommentsController < ApplicationController
  def show
    @comment = Comment.find_by(id: params[:id])
  end

  def create
    
    post = Post.find_by(id: params[:post])
    @comment = current_user.comments.build({content: params[:content], post: post, parent_id: params[:parent]})
    @comment.save!
    redirect_to "/posts/#{post.id}"
  end

  def destroy
  end
end
