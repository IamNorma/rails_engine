class Api::V1::RevenueController < ApplicationController
  def index
    total_revenue = Merchant.total_revenue(params[:start], params[:end])
    render json: MerchantSerializer.new(total_revenue)
  end
end
