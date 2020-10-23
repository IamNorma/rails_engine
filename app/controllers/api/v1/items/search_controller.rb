class Api::V1::Items::SearchController < ApplicationController
  def show
    attribute = params.keys.first
    query = params[attribute]
    item = if attribute == 'name' || attribute == "description"
             Item.where("lower(#{attribute}) LIKE ?", "%#{query.downcase}%").first
           elsif attribute == 'unit_price'
             Item.where("lower(#{attribute}) LIKE ?", "%#{query.to_f}%").first
           elsif attribute == 'merchant_id'
             Item.where("lower(#{attribute}) LIKE ?", "%#{query.to_i}%").first
           elsif attribute == 'created_at' || attribute == 'updated_at'
             Item.where("CAST(#{attribute} AS text) LIKE ?", "%#{query.downcase}%").first
           end
    render json: ItemSerializer.new(item)
  end
end
