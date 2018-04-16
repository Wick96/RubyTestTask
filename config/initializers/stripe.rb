Rails.configuration.stripe = {
  publishable_key: ENV["TEST_MY_PUBLISHABLE_KEY"],
  secret_key: ENV["TEST_MY_SECRET_KEY"]
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
Stripe.api_key = Rails.configuration.stripe[:publishable_key]
