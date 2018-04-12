class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.string :name
      t.datetime :start_time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
