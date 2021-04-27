class Api::V1::SessionsController < ApplicationController
  def create
    if clean_params?([:email, :password])
      user = User.find_by(email: params[:email].downcase)
      if user && user.authenticate(params[:password])
        render json: UsersSerializer.new(user)
      else
        render json: UserErrorSerializer.new, status: 401
      end
    else
      render json: UserErrorSerializer.new, status: 401
    end
  end

  private

  def clean_params?(param_categories)
    check = param_categories.map do |param_category|
      if params[param_category] == nil
        false
      elsif params[param_category] == ""
        false
      else
        true
      end
    end
    check.all?(true)
  end
end
