require 'rails_helper'

RSpec.describe Tea, type: :model do
  describe 'relationships' do
    it { should have_many :subscriptions }
    it { should have_many(:customers).through(:subscriptions) }
  end

  describe 'validations' do
    it { should validate_presence_of :brew_time }
    it { should validate_uniqueness_of :api_id }
    it { should validate_presence_of :api_id }
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
  end

  describe 'class methods' do
    #more to come
  end

  describe 'instance methods' do
    #more to come
  end
end
