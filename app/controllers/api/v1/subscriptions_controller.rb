class Api::V1::SubscriptionsController < ApplicationController
  def create
    sub = Subscription.find_by(customer_id: params[:customer_id], tea_id: params[:tea_id])
    if sub
      sub.status == 0
    elsif !sub
      new_sub = Subscription.create!(
        customer_id: params[:customer_id],
        tea_id: params[:tea_id],
        status: 0
      )
      render json: SubscriptionSerializer.new(new_sub).serialized_json
    end
  end
end
