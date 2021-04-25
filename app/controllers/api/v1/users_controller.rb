class Api::V1::UsersController < ApplicationController

  def register
    if clean_params?([:email, :password_digest, :password_confirmation])
      user = user_params
      user[:email] = user[:email].downcase
      existing_user = User.find_by(email: user[:email])

      user = User.find_or_create(user)
      if user.id == nil
        render json: UserErrorSerializer.new, status: 400
      elsif existing_user == nil
        render json: UsersSerializer.new(user), status: 201
      else
        render json: UserErrorSerializer.new, status: 400
      end
    else
      render json: UserErrorSerializer.new, status: 400
    end
  end

  private
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def clean_params?(param_categories)
    param_categories.each do |param_category|
      return false if params[param_category] == nil
      return false if params[param_category] == ""
      true
    end
  end
end
