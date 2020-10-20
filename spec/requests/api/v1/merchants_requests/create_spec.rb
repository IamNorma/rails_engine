require 'rails_helper'

RSpec.describe "Merchant API" do
  it "can create a new merchant" do
    merchant_params = ({
                    name: 'Walmart'
                  })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/merchants", headers: headers, params: JSON.generate(merchant: merchant_params)

    created_merchant = Merchant.last

    expect(response).to be_successful
    expect(created_merchant.name).to eq(merchant_params[:name])
  end
end
