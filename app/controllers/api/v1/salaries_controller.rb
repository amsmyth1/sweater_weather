class Api::V1::SalariesController < ApplicationController

  def city_info
    city_info = {}
    city_info[:destination] = params[:destination]
    city_info[:forecast] = city_forecast(params[:destination])
    city_info[:salaries] = city_salary_info(params[:destination])
    city_info
    render json: SalariesSerializer.new(OpenStruct.new(city_info))
  end

  def city_salary_info(location)
    salaries = city_all_salary_info(location)

    final_city_salaries = salaries.select do |salary|
      job_titles = ["Data Analyst", "Data Scientist", "Mobile Developer",
      "QA Engineer", "Software Engineer", "Systems Administrator", "Web Developer"]

      job_titles.any?(salary[:title])
    end
    final_city_salaries
  end

  private
  def city_all_salary_info(location)
    response = Faraday.get("https://api.teleport.org/api/urban_areas/slug:#{params[:destination]}/")
    raw_data = JSON.parse(response.body, symbolize_names: true)

    response = Faraday.get("https://api.teleport.org/api/urban_areas/teleport:#{raw_data[:ua_id]}/salaries/")
    raw_data = JSON.parse(response.body, symbolize_names: true)
    salaries = []
    raw_data[:salaries].map do |salary|
      salaries << salary_info(salary)
    end
    salaries
  end

  def salary_info(salary)
    salary_info = {}
    salary_info[:title] = salary[:job][:title]
    salary_info[:min] = present_salary(salary[:salary_percentiles].values.min)
    salary_info[:max] = present_salary(salary[:salary_percentiles].values.max)
    salary_info
  end

  def city_forecast(city)
  end

  def present_salary(salary)
    final_salary = []
    number_length = salary.floor(0).to_s.length
    salary.floor(0).to_s.split("").each_with_index do |character, index|
      if index == (number_length - 3)
        final_salary << ","
        final_salary << character
      else
        final_salary << character
      end
    end
    "$#{final_salary.join}.#{salary.round(2).to_s.split(//).last(2).join}"
  end
end
