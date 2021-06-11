require 'rails_helper'

describe "When a POST request is sent to /api/v1/subscribe" do
  describe "with the customer id and tea id" do
    # happy path
    it 'creates the subscription' do
      customer = create(:customer)
      tea = create(:tea)
      post '/api/v1/subscribe', params: { customer_id: customer.id, tea_id: tea.id }

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
      expect(parsed_response[:data][:attributes][:status]).to eq("active")
    end

    it 'activates a deactivated subscription' do
      customer = create(:customer)
      tea = create(:tea)
      subscription = Subscription.create!(customer_id: customer.id, tea_id: tea.id, status: 1)

      expect(subscription.status).to eq("inactive")
      post '/api/v1/subscribe', params: { customer_id: customer.id, tea_id: tea.id }

      expect(response).to have_http_status(:success)

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response[:data][:attributes][:status]).to eq("active")
    end

    # sad path
    it 'cant create a sub without a valid customer or a tea id' do
      customer = create(:customer)
      tea = create(:tea)

      post '/api/v1/subscribe', params: { tea_id: tea.id }
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response[:message]).to eq("Incorrect or not all necessary params supplied.")

      post '/api/v1/subscribe', params: { customer_id: customer.id }
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response[:message]).to eq("Incorrect or not all necessary params supplied.")

      post '/api/v1/subscribe'
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response[:message]).to eq("Incorrect or not all necessary params supplied.")

      post '/api/v1/subscribe', params: { customer_id: "dogs", tea_id: "bones" }
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response[:message]).to eq("Incorrect or not all necessary params supplied.")

      post '/api/v1/subscribe', params: { customer_id: "❤️", tea_id: tea.id }
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response[:message]).to eq("Incorrect or not all necessary params supplied.")
    end
  end
end
