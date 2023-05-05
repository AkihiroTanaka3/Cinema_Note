class Cast < ApplicationRecord
  has_many :casts_movies, dependent: :destroy
  has_many :movies, through: :casts_movies
  
  validates :name, presence: true
end
