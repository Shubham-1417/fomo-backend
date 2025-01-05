class Api::V1::CommentsController < ApplicationController
    def index
      comments = Comment.where(post_id: params[:post_id])
      render json: comments, status: :ok
    end
  
    def create
      comment = Comment.new(comment_params.merge(user_id: current_user.id, post_id: params[:post_id]))
      if comment.save
        render json: comment, status: :created
      else
        render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:content)
    end
  end
  