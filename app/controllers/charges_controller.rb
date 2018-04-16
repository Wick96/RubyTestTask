class ChargesController < ApplicationController
  skip_before_action :authenticate_user!
  protect_from_forgery except: :webhooks

  def create
    # Amount in cents
    booking = Booking.find(params[:booking_id])
    booking.update(paid: "onhold")

    CreatePaymentWorker.perform_async(params[:booking_id], params[:stripeEmail], params[:stripeToken])

    flash[:notice] = "Payment was submited!"
    redirect_to booking_path(booking)
  rescue Stripe::CardError => e
    flash[:notice] = e.message
    redirect_to booking_path(booking)
  end

  def webhooks
    begin
      WebhookStripeService.new(request).parse_Json
    rescue JSON::ParserError
      render json: { status: 400 }
      return
    rescue Stripe::SignatureVerificationError
      render json: { status: 400 }
      return
    rescue Exception
      render json: { status: 422, error: "Webhook call failed" }
      return
    end
    render json: { status: 200 }
  end
end
