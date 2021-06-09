require 'rails_helper'

describe 'when I send a GET request to /api/v1/subscriptions' do
  describe 'with the customer_id in params' do
    it 'shows a list of the customers subscriptions, active and not' do
      customer = create(:customer)
      tea1 = create(:tea)
      tea2 = create(:tea)
      tea3 = create(:tea)
      tea4 = create(:tea)
      tea5 = create(:tea)
      create(:subscription, customer_id: customer.id, tea_id: tea1.id)
      create(:subscription, customer_id: customer.id, tea_id: tea2.id)
      create(:subscription, customer_id: customer.id, tea_id: tea3.id)
      create(:subscription, customer_id: customer.id, tea_id: tea4.id)
      create(:subscription, customer_id: customer.id, tea_id: tea5.id)

      get "/api/v1/subscriptions", params: { customer_id: customer.id }
      expect(response).to have_http_status(:success)

      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response[:data])

      expect(parsed_response).to have_key(:data)
      expect(parsed_response[:data][0]).to have_key(:id)
      expect(parsed_response[:data][0][:id]).to_not be_nil
      expect(parsed_response[:data][0]).to have_key(:type)
      expect(parsed_response[:data][0][:type]).to eq("subscription")
      expect(parsed_response[:data][0]).to have_key(:attributes)
      expect(parsed_response[:data][0][:attributes]).to have_key(:customer_id)
      expect(parsed_response[:data][0][:attributes]).to have_key(:tea_id)
      expect(parsed_response[:data][0][:attributes]).to have_key(:status)
      expect(parsed_response[:data].count).to eq(5)
      expect(parsed_response[:data].all? {|sub| sub[:attributes][:customer_id] == customer.id}).to eq(true)
      expect(parsed_response[:data].all? {|sub| sub[:attributes][:tea_id] == tea1.id}).to eq(false)
    end
  end
end
