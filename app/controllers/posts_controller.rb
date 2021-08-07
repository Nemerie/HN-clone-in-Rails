# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :logged_in_user, only: %i[upvote create]

  def new; end

  def create
    @post = current_user.posts.build(post_params)
    redirect_to root_url if @post.save
  end

  def show
    @post = Post.find_by(id: params[:id])
    @comment_tree = comment_tree(Comment.where(post_id: @post.id).order('created_at DESC'))
  end

  def index
    conditions = {}

    if params[:date]
      begin
        @date = Date.parse(params[:date])
        conditions[:created_at] = @date.beginning_of_day..@date.end_of_day
      rescue ArgumentError
        @date = Date.today
      end
    end

    if params[:user_id]
      user_id = params[:user_id]
      @username = User.find_by(id: user_id)
      conditions[:user_id] = user_id
    end

    @page = params[:page] || 1
    @posts = Post.where(conditions).order('created_at DESC').paginate(page: @page, per_page: 30)
  end

  def past
    date = params[:date] || Date.today

    @date = begin
      Date.parse(date.to_s)
    rescue ArgumentError
      Date.today
    end

    @page = params[:page] || 1
    @posts = Post.where(created_at: (@date.beginning_of_day..@date.end_of_day))
                 .order('created_at DESC').paginate(page: @page, per_page: 30)

    render :index
  end

  def upvote
    votable = { type: 'Post', id: params[:id] }

    if current_user.upvoted?(votable)
      current_user.remove_vote(votable)
    else
      current_user.upvote(votable)
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def post_params
    params.permit(:title, :url)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end

  # transform a tree of comments:
  # A
  #   B
  #     C
  #     D
  #   E
  #   F
  # into a list sorted from top to down:
  # [A, B, C, D, E, F]
  # where every comment is wraped as {comment: Comment, depth: Integer}
  def comment_tree(comments)
    candidates = [nil]
    flat_comments = []

    until candidates.empty?
      current_candidate = candidates.pop
      flat_comments.push(current_candidate) unless current_candidate.nil?

      selected = comments.select do |comment|
        comment.parent_id == (current_candidate.nil? ? nil : current_candidate.id)
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
      until c.parent_id == stack_of_previous.last
        stack_of_previous.pop
        depth -= 1
      end

      stack_of_previous.push(c.id)
      depth += 1

      tree.push({ comment: c, depth: depth })
    end

    tree
  end
end
