class AttendancesController < ApplicationController
  def create
    @booking = Booking.find(params[:booking_id])
    @attendance = Attendance.find_or_initialize_by(
      booking_id: params[:booking_id],
      user_id: current_user.id
      )
    if @attendance.save
      AttendanceMailer.with(user: current_user, booking: @booking).attendance_email.deliver_later
      flash[:notice] = "You successfully attendance to this event!"
      redirect_to booking_path(@booking)
    else
      redirect_to bookings_path
    end
  end

  def destroy
    @attendance = Attendance.find(params[:id])
    @attendance.destroy
    flash[:notice] = "Your attendance was removed!"
    redirect_to booking_path(@attendance.booking)
  end

  def attendance_params
    params.require(:booking).permit(:user, :booking)
  end
end
