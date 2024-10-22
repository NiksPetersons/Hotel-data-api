require 'rails_helper'

RSpec.describe HotelDataFetcher do
  let(:fetcher) { HotelDataFetcher.new }

  describe '#fetch_and_save' do
    before do
      HotelDataFetcher::CITIES_AND_TOWNS.each do |city|
        stub_request(:get, "https://nominatim.openstreetmap.org/search?q=Hotels%20in%20#{city}&format=json")
          .to_return(status: 200, body: [
            { "display_name" => "Hotel A" },
            { "display_name" => "Hotel B" }
          ].to_json)
      end
    end

    it 'creates hotels for each result' do
      expect { fetcher.fetch_and_save }.to change(Hotel, :count).by(HotelDataFetcher::CITIES_AND_TOWNS.count * 2)
    end

    it 'creates hotels with correct attributes' do
      fetcher.fetch_and_save
      HotelDataFetcher::CITIES_AND_TOWNS.each do |city|
        city_hotels = City.find_by(name: city).hotels
        expect(city_hotels.pluck(:display_name)).to contain_exactly("Hotel A", "Hotel B")
      end
    end

    context 'when API request fails' do
      before do
        allow(Net::HTTP).to receive(:get_response).and_return(
          instance_double(Net::HTTPBadRequest, is_a?: false)
        )
      end

      it 'does not create any hotels' do
        expect { fetcher.fetch_and_save }.not_to change(Hotel, :count)
      end
    end
  end
end