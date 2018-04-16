Rails.configuration.stripe = {
  publishable_key: "pk_test_FjSWfxkVf20E4x4It0mhp2SM",
  secret_key: ENV["TEST_MY_SECRET_KEY"]
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
