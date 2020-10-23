require 'rails_helper'

RSpec.describe Revenue do
  it 'exists' do
    id = nil
    total = 150.55

    revenue = Revenue.new(id, total)

    expect(revenue).to be_a(Revenue)
    expect(revenue.id).to eq(nil)
    expect(revenue.total).to eq(150.55)
  end
end
