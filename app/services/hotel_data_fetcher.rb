require 'uri'
require 'net/http'

class HotelDataFetcher
  CITIES_AND_TOWNS = %w[
    Daugavpils
    Jelgava
    Jurmala
    Liepaja
    Rezekne
    Riga
    Ventspils
    Sigulda
    Cesis
    Kuldiga
  ].freeze

  def fetch_and_save
    ActiveRecord::Base.transaction do
      CITIES_AND_TOWNS.each do |city_name|
        city = City.find_or_create_by!(name: city_name)

        uri = URI("https://nominatim.openstreetmap.org/search?q=Hotels%20in%20#{city_name}&format=json")
        res = Net::HTTP.get_response(uri)

        @results = res.is_a?(Net::HTTPSuccess) ? JSON.parse(res.body) : []

        @results.each do |result|
          hotel = city.hotels.new(display_name: result["display_name"])
          if hotel.valid?
            hotel.save!
          else
            Rails.logger.error("Failed to create hotel: #{hotel.errors.full_messages.join(', ')}")
          end
        end
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Failed to create city: #{e.message}")
  end
end
