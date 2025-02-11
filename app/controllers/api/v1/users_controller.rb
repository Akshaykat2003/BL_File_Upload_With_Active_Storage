class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :upload_profile_picture]
  skip_before_action :verify_authenticity_token, only: [:create]

  def show
    render json: @user
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: { message: "User created", user: user }, status: :created
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def upload_profile_picture
    @user = User.find(params[:id])
    
    if params[:profile_picture].present?
      @user.profile_picture.attach(
        io: params[:profile_picture].tempfile,
        filename: params[:profile_picture].original_filename,
        content_type: params[:profile_picture].content_type
      )
    end
  
    if @user.save
      render json: { message: "Profile picture uploaded successfully" }, status: :ok
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  
  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: :not_found
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
