class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    merchants = Merchant.most_revenue(limit)
    render json: MerchantSerializer(merchants)
  end
end
