class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: %i[show update destroy]
  
    # List all users (Only accessible by super_admin)
    def index
      authorize User
      @pagy, @users = pagy(User.all)
      render json: @users
    end
  
    # Show a single user
    def show
      authorize User
      render json: @user
    end
  
    # Create a new user
    def create
      authorize User
      @user = User.new(user_params)
      if @user.save
        render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  
    # Update an existing user
    def update
      authorize User
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  
    # Delete a user
    def destroy
      authorize User
      @user.destroy
      head :no_content
    end
  
    private
  
    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
      params.permit(:first_name, :last_name, :email, :password, :phone, :address, :gender, :dob)
    end
  
  end