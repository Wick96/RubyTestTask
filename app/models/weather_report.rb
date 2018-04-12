class WeatherReport < ApplicationRecord
  validates :date, presence: true
  validates :temperature, presence: true
  validates :description, presence: true
end
