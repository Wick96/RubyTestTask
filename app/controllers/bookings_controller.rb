
class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  def index
    start_date = DateTime.now.beginning_of_month
    start_date = DateTime.parse(params[:start_date]).beginning_of_month if params[:start_date]

    end_date = start_date.end_of_month

    @bookings = Booking.where("start_time > ? and start_time < ?", start_date, end_date)
    @weather = WeatherReport.where("date > ? and date < ?", start_date, end_date)
  end
  def show
    @booking = Booking.includes(attendances: :user).find(params[:id])
    @user_attendance = @booking.attendances.find_by(user: current_user)
  end

  def new
    @booking = Booking.new
  end

  def edit; end

  def create
    @booking = current_user.bookings.build(booking_params)
    if @booking.save
      flash[:notice] = "Booking was successfully created."
      redirect_to bookings_path
    else
      render :new
    end
  end

  def update; end

  def destroy; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_booking
    @booking = Booking.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def booking_params
    params.require(:booking).permit(:name, :start_time, :description)
  end
end
