module Api
  module V1
    class PostsController < ApplicationController
      # GET /api/v1/posts
      def index
        posts = Post.all
        render json: posts, status: :ok
      end

      # GET /api/v1/posts/:id
      def show
        post = Post.find(params[:id])
        render json: post, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Post not found' }, status: :not_found
      end

      # POST /api/v1/posts
      def create
        post = Post.new(post_params)
        if post.save
          render json: post, status: :created
        else
          render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PUT /api/v1/posts/:id
      def update
        post = Post.find(params[:id])
        if post.update(post_params)
          render json: post, status: :ok
        else
          render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Post not found' }, status: :not_found
      end

      # DELETE /api/v1/posts/:id
      def destroy
        post = Post.find(params[:id])
        post.destroy
        render json: { message: 'Post deleted successfully' }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Post not found' }, status: :not_found
      end

      # GET /api/v1/posts/search
      def search
        query = params[:q]
        posts = Post.where("title ILIKE ? OR content ILIKE ?", "%#{query}%", "%#{query}%")
        render json: posts, status: :ok
      end

      private

      def post_params
        params.require(:post).permit(:title, :content, :scope, :user_id)
      end
    end
  end
end
