module Api
    module V1
      class UsersController < ApplicationController
        # POST /api/v1/auth/register
        def register
          user = User.new(user_params)
          if user.save
            render json: { message: "User created successfully" }, status: :created
          else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
          end
        end
  
        # POST /api/v1/auth/login
        def login
          user = User.find_by(pseudonym: params[:pseudonym])
          if user&.authenticate(params[:password])
            render json: { message: "Login successful", user: user }, status: :ok
          else
            render json: { error: "Invalid credentials" }, status: :unauthorized
          end
        end
  
        # DELETE /api/v1/auth/logout
        def logout
          render json: { message: "Logout successful" }, status: :ok
        end
  
        # GET /api/v1/users/:id
        def show
          user = User.find_by(id: params[:id])
          if user
            render json: user, status: :ok
          else
            render json: { error: "User not found" }, status: :not_found
          end
        end
  
        private
  
        def user_params
          params.require(:user).permit(:pseudonym, :password, :bio)
        end
      end
    end
  end
  