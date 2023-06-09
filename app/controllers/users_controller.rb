class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def index
    render json: User.all
  end

  def show
    user = User.where(:id => params[:id])
    if user  && session[:user_id] == user[0].id
      render json: user
    elsif user
      render json: {errors: ["Not Authorized"]}, status: :unauthorized
    else
      render_not_found_response
    end
  end

  def create
    user = User.create(user_params)
    if user.valid?
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find_by(id: params[:id])
    if user 
      user.destroy
      head :no_content
    else
      render json: {errors: ["User Does Not Exist"]}, status: :not_found
    end
  end

  private
  # all methods below here are private

  def user_params
    params.permit(:password, :password_confirmation, :bio, :username)
  end

end
