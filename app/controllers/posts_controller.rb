class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  respond_to :html

  before_action :permit_user, only: [:edit, :destroy]

  def upvote 
    @post = Post.find(params[:id])
    @post.upvote_by current_user
    redirect_to :back
  end  

  def downvote
    @post = Post.find(params[:id])
    @post.downvote_by current_user
    redirect_to :back
  end

  def index
    @posts = Post.find_posts(current_user)
    respond_with(@posts)
  end

  def show
    respond_with(@post)
  end

  def new
    @post = Post.new
    respond_with(@post)
  end

  def edit
  end

  def create
    @post = Post.new(post_params) do |post|
      post.user = current_user
    end
    if @post.save
      redirect_to root_path
    else
      redirect_to root_path, notice: @post.errors.full_messages.first
    end
  end

  def update
    @post.update(post_params)
    respond_with(@post)
  end

  def destroy
    @post.destroy
    redirect_to :back
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:attachment, :content, :is_public, :user_id)
    end

    def permit_user
      if (current_user.id != @post.user_id)
        redirect_to :back, :notice => "Can not edit/delete this post."
      end
    end
end
