class PostsController < ApplicationController
  #before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_url
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    @comment_tree = comment_tree(Comment.where(post_id: @post.id)) 
  end

  def index
    @page = params[:page] || 1
    @posts = Post.paginate(page: @page, per_page: 30)
  end

  def destroy
    @post.destroy
  end

  private

    def post_params
      params.permit(:title, :url)
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end

    def comment_tree(comments)
      candidates = [nil]
      flat_comments = []

      until candidates.empty?
        current_candidate = candidates.pop
        flat_comments.push(current_candidate) unless current_candidate.nil?

        selected = comments.select do |comment|
          comment.comment_id == (current_candidate.nil? ? nil : current_candidate.id)
        end

        selected.reverse.each do |c|
          candidates.push(c)
        end
      end

      parent = nil
      stack_of_previous = []
      depth = -1
      tree = []

      flat_comments.each do |c|
        until c.comment_id == stack_of_previous.last
          stack_of_previous.pop
          depth -= 1
        end

        stack_of_previous.push(c.id)
        depth += 1

        tree.push({comment: c, depth: depth})
      end

      tree
    end
end
