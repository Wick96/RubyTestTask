require "rails_helper"

RSpec.describe BookingsController, type: :controller do
  let(:user) do
    User.create(email: "test@example.com", password: "password", password_confirmation: "password")
  end
  let(:booking) do
    user.bookings.create(name: "Loli", start_time: "2018-05-17 00:00:00")
  end
  let(:booking2) do
    user.bookings.create(name: "Poli", start_time: "2018-06-17 00:00:00")
  end
  let(:booking3) do
    user.bookings.create(name: "Moli", start_time: "2018-04-19 00:00:00")
  end
  describe "GET index" do
    context "user is logged in" do
      it "shows a list of bookings" do
        sign_in user
        get :index, params: { start_date: "2018-05-15" }
        expect(response).to render_template("index")
        expect(assigns(:bookings)).to eq [booking]
        expect(assigns(:bookings2)).to eq nil
      end
    end
    context "user is not logged in" do
      it "redirects to the login page" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "POST create" do
    context "booking is vaild" do
      it "creates a booking" do
        sign_in(user)

        post :create, params: {
          booking: {
            name: "Marjan",
            start_time: "2018-04-19 00:00:00"
          }
        }
        expect(Booking.find_by(name: "Marjan")).to_not be_nil
        expect(response.status).to eq 302
      end
    end
    context "booking overlaps with existing booking" do
      it "doesn't save the booking" do
        sign_in(user)

        post :create, params: {
          booking: {
            name: "Marjan",
            start_time: booking.start_time
          }
        }
        expect(Booking.find_by(name: "Marjan")).to be_nil
        expect(assigns(:booking).errors.messages.length).to eq 1
        expect(response.status).to eq 200
      end
    end
  end
end
