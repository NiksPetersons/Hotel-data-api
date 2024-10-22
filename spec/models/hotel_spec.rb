require 'rails_helper'

RSpec.describe Hotel, type: :model do
  describe 'associations' do
    it { should belong_to(:city) }
  end

  describe 'validations' do
    subject { FactoryBot.build(:hotel) }

    it { should validate_presence_of(:display_name) }
    it { should validate_presence_of(:city) }
    it { should validate_uniqueness_of(:display_name).scoped_to(:city_id).case_insensitive }
  end
end
