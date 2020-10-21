require 'rails_helper'

RSpec.describe "Merchant API" do
  it "can delete a new merchant" do
    merchant = create(:merchant)

    expect(Merchant.count).to eq(1)

    expect{ delete "/api/v1/merchants/#{merchant.id}" }.to change(Merchant, :count).by(-1)

    expect(response).to be_successful
    expect(Merchant.count).to eq(0)
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
