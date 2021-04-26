class Api::V1::SalariesController < ApplicationController

  def city_info
    render json: SalariesSerializer.new(SalariesFacade.final_city_info(params[:destination]))
  end
end
