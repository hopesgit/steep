class SubscriptionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :customer_id, :tea_id, :status
end
