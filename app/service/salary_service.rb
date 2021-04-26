class SalaryService

  def self.search_ua_id(location)
    response = Faraday.get("https://api.teleport.org/api/urban_areas/slug:#{location}/")
    raw_data = JSON.parse(response.body, symbolize_names: true)
    raw_data[:ua_id]
  end
  
  def self.full_name(location)
    response = Faraday.get("https://api.teleport.org/api/urban_areas/slug:#{location}/")
    raw_data = JSON.parse(response.body, symbolize_names: true)
    raw_data[:full_name]
  end

  def self.city_salary_info(location)
    salaries = city_all_salary_info(location)

    final_city_salaries = salaries.select do |salary|
      job_titles = ["Data Analyst", "Data Scientist", "Mobile Developer",
      "QA Engineer", "Software Engineer", "Systems Administrator", "Web Developer"]

      job_titles.any?(salary[:title])
    end
    final_city_salaries
  end

  def self.city_all_salary_info(location)
    response = Faraday.get("https://api.teleport.org/api/urban_areas/teleport:#{search_ua_id(location)}/salaries/")
    raw_data = JSON.parse(response.body, symbolize_names: true)
    salaries = []
    raw_data[:salaries].map do |salary|
      salaries << salary_info(salary)
    end
    salaries
  end

  def self.salary_info(salary)
    salary_info = {}
    salary_info[:title] = salary[:job][:title]
    salary_info[:min] = present_salary(salary[:salary_percentiles].values.min)
    salary_info[:max] = present_salary(salary[:salary_percentiles].values.max)
    salary_info
  end

  def self.present_salary(salary)
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
