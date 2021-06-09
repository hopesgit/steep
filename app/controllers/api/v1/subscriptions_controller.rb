class Api::V1::SubscriptionsController < ApplicationController
  def show
    customer = Customer.find(params[:customer_id])
    if customer
      render json: SubscriptionSerializer.new(customer.subscriptions).serialized_json
    end
  end

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
  end

  def delete
    sub = Subscription.find_by(customer_id: params[:customer_id], tea_id: params[:tea_id])
    if sub && sub.active?
      sub.status = 1
      sub.save
    end
    render json: SubscriptionSerializer.new(sub).serialized_json
  end
end
