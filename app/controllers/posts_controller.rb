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
  end

  def index
    @posts = Post.all
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
end
