require 'rails_helper'

RSpec.describe "Merchant API" do
  it "can create a new merchant" do
    merchant_params = ({
                    name: 'Walmart'
                  })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/merchants", headers: headers, params: JSON.generate(merchant: merchant_params)

    merchant = JSON.parse(response.body, symbolize_names: true)

    last_merchant = Merchant.last

    expect(response).to be_successful
    expect(last_merchant.name).to eq(merchant_params[:name])

    expect(merchant[:data]).to be_a(Hash)

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to be_a(String)

    expect(merchant[:data]).to have_key(:type)
    expect(merchant[:data][:type]).to be_a(String)

    expect(merchant[:data]).to have_key(:attributes)
    expect(merchant[:data][:attributes]).to be_a(Hash)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end
end
