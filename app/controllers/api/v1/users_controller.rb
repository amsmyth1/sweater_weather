class Api::V1::UsersController < ApplicationController

  def register
    user = user_params
    user[:email] = user[:email].downcase
    existing_user = User.find_by(email: user[:email])
    user = User.find_or_create(user)
    if existing_user == nil
      render json: UsersSerializer.new(user), status: 201
    else
      render json: UserRegistrationErrorSerializer.new, status: 400
    end
  end

  private
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
