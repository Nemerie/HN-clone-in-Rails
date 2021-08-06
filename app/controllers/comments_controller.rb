class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:upvote, :create]

  def show
    @comment = Comment.find_by(id: params[:id])
  end

  def create
    post = Post.find_by(id: params[:post])
    @comment = current_user.comments.build({content: params[:content], post: post, parent_id: params[:parent]})
    @comment.save!

    redirect_to "/posts/#{post.id}"
  end

  def upvote
    votable = {type: 'Comment', id: params[:id]}

    if current_user.upvoted?(votable)
      current_user.remove_vote(votable)
    else
      current_user.upvote(votable)
    end

    redirect_back(fallback_location: root_path)
  end
end
