class RemoveCityFromHotels < ActiveRecord::Migration[7.1]
  def change
    remove_column :hotels, :city, :string
  end
end
