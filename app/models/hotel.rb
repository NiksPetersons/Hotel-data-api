class Hotel < ApplicationRecord
  belongs_to :city

  validates :display_name, presence: true, uniqueness: { scope: :city_id, case_sensitive: false }
  validates :city, presence: true
end
