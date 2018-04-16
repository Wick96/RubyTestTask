class CreatePaymentWorker
  include Sidekiq::Worker

  def perform(booking_id, email, token)
    customer = Stripe::Customer.create(
      email: email,
      source: token
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: 1000,
      description: "Rails Stripe customer",
      currency: "usd",
      metadata: { "booking_id" => booking_id }
    )
  end
end
