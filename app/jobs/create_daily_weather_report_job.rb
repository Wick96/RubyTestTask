require "open_weather"
class CreateDailyWeatherReportJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    api_weather_reports.each do |weather_report|
      WeatherReport.where(date: DateTime.parse(weather_report["dt_txt"])).first_or_create(
        weather_report_atributes(weather_report)
      )
    end
  end

  private

  def weather_report_atributes(api_response_json)
    {
      date: DateTime.parse(api_response_json["dt_txt"]),
      temperature: api_response_json["main"]["temp"],
      description: api_response_json["weather"][0]["description"]
    }
  end

  def api_weather_reports
    OpenWeather::Forecast.city_id(
      "3196359",
      units: "metric", APPID: ENV["WEATHER_KEY"]
    )["list"]
  end
end
