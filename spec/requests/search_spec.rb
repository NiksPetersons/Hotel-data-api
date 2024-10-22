require 'rails_helper'

RSpec.describe "/search", type: :request do
  let!(:sigulda) { create(:city, name: 'Sigulda') }
  let!(:kuldiga) { create(:city, name: 'Kuldīga') }

  let!(:hotel_pils) { create(:hotel, display_name: "Hotel Pils, 4B, Pils iela, Sigulda", city: sigulda) }
  let!(:kakis) { create(:hotel, display_name: "Kaķis, 8A, Pils iela, Sigulda", city: sigulda) }
  let!(:kaku_maja) { create(:hotel, display_name: "Kaķu māja, 8, Cita iela, Sigulda", city: sigulda) }
  let!(:ezisa_miga) { create(:hotel, display_name: "Ezīša miga, 6, Pilsētas laukums, Kuldīga", city: kuldiga) }

  describe "GET /api/search.json" do
    context "when searching for hotels in Sigulda with 'Pils' in the name" do
      let(:params) { { city: "Sigulda", q: "Pils" } }
      let(:expected_result) {
        [
          hotel_pils.display_name,
          kakis.display_name
        ]
      }

      it "returns results under 100ms" do
        start_time = Time.now
        get("/api/search.json", params: params)
        end_time = Time.now
        request_time = end_time - start_time

        expect(request_time.to_f).to be < 0.1 # under 100ms
      end

      it "returns correct hotels" do
        get "/api/search.json", params: params

        parsed_response = JSON.parse(response.body)
        names = parsed_response.map { |el| el["display_name"] }
        expect(names).to eq(expected_result)
      end
    end

    context "when searching for hotels with '4B' in the name" do
      let(:params) { { q: "4B" } }
      let(:expected_result) {
        [
          {
            "display_name" => hotel_pils.display_name,
            "city" => {
              "name" => sigulda.name,
              "coat_of_arms" => sigulda.coat_of_arms
            }
          }
        ]
      }

      it "returns only display_name and city name and coat_of_arms" do
        get "/api/search.json", params: params
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to eq(expected_result)
      end
    end
  end
end
