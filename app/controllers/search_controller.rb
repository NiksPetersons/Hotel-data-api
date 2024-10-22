class SearchController < ApplicationController

  def index
    get_data unless Hotel.any?

    hotels = Hotel.includes(:city).all
    filtered_hotels = apply_filters(hotels)

    render json: filtered_hotels.as_json(
      only: :display_name,
      include: { city: { only: [:name, :coat_of_arms] } }
    )
  end

  private

  def get_data
    HotelDataFetcher.new.fetch_and_save
  end

  def apply_filters(hotels)
    hotels = hotels.where('hotels.display_name ILIKE ?', "%#{params[:q]}%") if params[:q].present?
    hotels = hotels.joins(:city).where('cities.name ILIKE ?', "%#{params[:city]}%") if params[:city].present?

    hotels
  end
end
