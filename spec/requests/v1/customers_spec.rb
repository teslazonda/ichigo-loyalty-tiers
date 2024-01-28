require 'rails_helper'

RSpec.describe "V1::Customers", type: :request do
  describe "GET /v1/customers/show/:customer_id" do
    it "returns http success" do
      customer = create(:customer)

      get "/v1/customers/#{customer.id}"
      expect(response).to have_http_status(:success)
    end
  end

end
