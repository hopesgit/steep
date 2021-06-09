require 'rails_helper'

describe "When a POST request is sent to /api/v1/unsubscribe" do
  describe "with the customer id and tea id" do
    # happy path
    it 'deactivates the subscription' do
      customer = create(:customer)
      tea = create(:tea)
      subscription = Subscription.create!(customer_id: customer.id, tea_id: tea.id, status: 0)

      expect(subscription.status).to eq("active")

      post '/api/v1/unsubscribe', params: { customer_id: customer.id, tea_id: tea.id }

      expect(response).to have_http_status(:success)

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response).to have_key(:data)
      expect(parsed_response[:data]).to have_key(:id)
      expect(parsed_response[:data][:id]).to_not be_nil
      expect(parsed_response[:data]).to have_key(:type)
      expect(parsed_response[:data][:type]).to eq("subscription")
      expect(parsed_response[:data]).to have_key(:attributes)
      expect(parsed_response[:data][:attributes]).to have_key(:customer_id)
      expect(parsed_response[:data][:attributes]).to have_key(:tea_id)
      expect(parsed_response[:data][:attributes]).to have_key(:status)

      expect(parsed_response[:data][:attributes][:customer_id]).to eq(customer.id)
      expect(parsed_response[:data][:attributes][:tea_id]).to eq(tea.id)
      expect(parsed_response[:data][:attributes][:status]).to eq("inactive")
    end

    it 'makes no change if the subscription is already inactive' do
      customer = create(:customer)
      tea = create(:tea)
      sub = Subscription.create!(customer_id: customer.id, tea_id: tea.id, status: 1)
      expect(sub.inactive?).to eq(true)

      post '/api/v1/unsubscribe', params: { customer_id: customer.id, tea_id: tea.id }

      expect(response).to have_http_status(:success)

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response[:data][:attributes][:status]).to eq("inactive")
    end

    it 'sends an error if the sub doesnt exist' do
      customer = create(:customer)
      tea = create(:tea)

      post '/api/v1/unsubscribe', params: { customer_id: customer.id, tea_id: tea.id }

      expect(response).to have_http_status(404)


      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response[:data]).to eq(nil)
    end

    # sad path
  end
end
