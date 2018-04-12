class AttendanceMailer < ApplicationMailer
  default from: "info@Cccemetery.com"

  def attendance_email
    @booking = params[:booking]
    @user = params[:user]
    mail(to: @user.email, subject: "You submit attendance to event #{@booking.name}!")
  end
end
