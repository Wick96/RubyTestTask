class CreateWeatherReports < ActiveRecord::Migration[5.1]
  def change
    create_table :weather_reports do |t|
      t.datetime :date, null: false
      t.string :temperature, null: false
      t.string :description, null: false

      t.timestamps
    end
  end
end
