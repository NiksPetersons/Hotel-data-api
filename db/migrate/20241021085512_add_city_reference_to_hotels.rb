class AddCityReferenceToHotels < ActiveRecord::Migration[7.1]
  def change
    add_reference :hotels, :city, null: false, foreign_key: { on_delete: :cascade }
  end
end
