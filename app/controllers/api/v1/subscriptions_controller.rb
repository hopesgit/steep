class Api::V1::SubscriptionsController < ApplicationController
  def create
    sub = Subscription.find_by(customer_id: params[:customer_id], tea_id: params[:tea_id])
    if sub
      sub.status = 0
      sub.save
      render json: SubscriptionSerializer.new(sub).serialized_json
    elsif !sub
      new_sub = Subscription.create!(
        customer_id: params[:customer_id],
        tea_id: params[:tea_id],
        status: 0
      )
      render json: SubscriptionSerializer.new(new_sub).serialized_json
    end

    def delete
      sub = Subscription.find_by(customer_id: params[:customer_id], tea_id: params[:tea_id])
      if sub && sub.active?
        sub.status = 1
        sub.save
        render json: SubscriptionSerializer.new(sub).serialized_json
      elsif !sub
        render json: "The subscription doesn't exist or the wrong parameters were provided.".to_json, status: 204
      else
        render json: SubscriptionSerializer.new(sub).serialized_json
      end
    end
  end
end
