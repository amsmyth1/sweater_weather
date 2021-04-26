class Api::V1::SalariesController < ApplicationController

  def city_info
    if SalariesFacade.location_check?(params[:destination])
      render json: SalariesSerializer.new(SalariesFacade.final_city_info(params[:destination]))
    else
      render json: NullSerializer.new, status: 204
    end
  end
end
