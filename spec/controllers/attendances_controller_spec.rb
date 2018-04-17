require "rails_helper"

RSpec.describe AttendancesController, type: :controller do
  let(:user) do
    User.create(email: "test@example.com", password: "password", password_confirmation: "password")
  end

  #describe "GET #new" do
  #  it "returns http success" do
  #    sign_in user
  #    get :create
  #    expect(response).to have_http_status(:success)
  #  end
  #end
end
