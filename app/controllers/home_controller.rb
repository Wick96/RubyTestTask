class HomeController < ApplicationController
  def index
    redirect_to bookings_path if user_signed_in?
  end
end
