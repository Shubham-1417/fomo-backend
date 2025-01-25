module Api
    module V1
      class TagsController < ApplicationController
        def index
          tags = Tag.all
          render json: tags, status: :ok
        end
  
        def posts_by_tag
          tag = Tag.find(params[:tag_id])
          posts = tag.posts
          render json: posts, status: :ok
        rescue ActiveRecord::RecordNotFound
          render json: { error: 'Tag not found' }, status: :not_found
        end
      end
    end
  end
  