class City < ApplicationRecord
  has_many :hotels, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :coat_of_arms, url: true, allow_blank: true
end
