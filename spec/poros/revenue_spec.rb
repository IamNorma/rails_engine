require 'rails_helper'

RSpec.describe Revenue do
  it 'exists' do
    revenue = 150.55

    revenue = Revenue.new(revenue)

    expect(revenue).to be_a(Revenue)
    expect(revenue.id).to eq(nil)
    expect(revenue.revenue).to eq(150.55)
  end
end
