class ChangePaidToBeStringInBookings < ActiveRecord::Migration[5.1]
  def change
    change_column :bookings, :paid, :string
  end
end
