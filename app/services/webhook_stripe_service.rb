class WebhookStripeService
  def initialize(request)
    @request = request
  end

  def parse_Json
    endpoint_secret = ENV["WEBHOOK_KEY"]
    payload = @request.body.read
    sig_header = @request.env["HTTP_STRIPE_SIGNATURE"]

    Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)

    event_json = JSON.parse(payload)
    event_object = event_json["data"]["object"]

    if event_json["type"] == "charge.succeeded"
      booking_id = event_object["metadata"]["booking_id"]
      booking = Booking.find(booking_id)
      booking.update(paid: "true")
      handle_success_charge event_object
    end
  end
end
