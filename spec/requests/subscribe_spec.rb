require 'rails_helper'

describe "When a POST request is sent to /api/v1/subscribe" do
  describe "with the customer id and tea id" do
    it 'creates the subscription' do
      post '/api/v1/subscribe', params: { customer_id: 25, tea_id: 5 }

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

      expect(parsed_response[:data][:attributes][:customer_id]).to eq(25)
      expect(parsed_response[:data][:attributes][:tea_id]).to eq(5)
      expect(parsed_response[:data][:attributes][:status]).to eq("active")

    end
  end
end
