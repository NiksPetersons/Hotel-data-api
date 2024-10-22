class CreateCities < ActiveRecord::Migration[7.1]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :coat_of_arms

      t.timestamps
    end

    add_index :cities, :name
  end
end
