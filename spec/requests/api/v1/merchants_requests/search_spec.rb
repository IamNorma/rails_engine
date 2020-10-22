require 'rails_helper'

describe "Merchants Search API" do
  it 'can find a single merchant that contains a fragment, case insensitive' do
    merchant1 = create(:merchant, name: "Walmart")
    merchant2 = create(:merchant, name: "Turing")

    get "/api/v1/merchants/find?name=ring"

    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)
  end
end
