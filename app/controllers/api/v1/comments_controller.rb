class Api::V1::CommentsController < ApplicationController
  before_action :set_post
  before_action :authenticate_user!, only: [:create, :update, :destroy]

  def index
    comments = @post.comments
    render json: comments, status: :ok
  end

  def create
    comment = @post.comments.new(comment_params.merge(user_id: current_user.id))
    if comment.save
      render json: comment, status: :created
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    comment = @post.comments.find(params[:id])
    if comment.update(comment_params)
      render json: comment, status: :ok
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    comment = @post.comments.find(params[:id])
    comment.destroy
    render json: { message: 'Comment deleted successfully' }, status: :ok
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Post not found' }, status: :not_found
  end

  def authenticate_user!
    unless current_user
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def current_user
    
    @current_user ||= User.find_by(id: session[:user_id]) 
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
