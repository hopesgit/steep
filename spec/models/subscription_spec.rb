require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should belong_to :tea }
  end

  describe 'validations' do
    it { should validate_presence_of :tea_id }
    it { should validate_presence_of :customer_id }
    it { should validate_presence_of :status }
  end

  describe 'class methods' do
    #more to come
  end

  describe 'instance methods' do
    #more to come
  end
end
