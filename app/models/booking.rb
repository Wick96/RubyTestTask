class Booking < ApplicationRecord
  belongs_to :user
  validates :start_time, uniqueness: { message: "This termin is already reserved!" }
  has_many :attendances
end
