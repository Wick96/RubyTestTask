require "clockwork"
require "./config/boot"
require "./config/environment"
require "sidekiq"

# load all jobs from app/jobs directory
# no need to load rails env, we only care about classes
# (#perform method is not invoked in this process)
Dir["app/jobs/*"].each { |f| load f }

module Clockwork
  every(1.day, "save_weather.job", at: "10:51") do
    CreateDailyWeatherReportJob.perform_later
  end
end
