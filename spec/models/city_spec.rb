require 'rails_helper'

RSpec.describe City, type: :model do
  describe 'associations' do
    it { should have_many(:hotels) }
  end

  describe 'validations' do
    subject { build(:city) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should allow_value('https://example.com/coat_of_arms.png').for(:coat_of_arms) }
    it { should allow_value('').for(:coat_of_arms) }
    it { should_not allow_value('invalid_url').for(:coat_of_arms) }
  end
end
