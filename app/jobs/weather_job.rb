require "open_weather"
class WeatherJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    options = { units: "metric", APPID: ENV["WEATHER_KEY"] }
    weather = OpenWeather::Forecast.city_id("3196359", options)
    weather["list"].each do |x|
      date = x["dt_txt"]
      next if Weather.exists?(date: date)
      desc = x["weather"][0]["description"]
      temp = x["main"]["temp"]
      Weather.create(date: date, temp: temp, weather: desc)
    end
  end

end
