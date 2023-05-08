class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :casts_movies, dependent: :destroy
  # has_many :casts, through: :casts_movies
  # belongs_to :genre
  
  validates :name, presence: true
  validates :year, presence: true
  validates :overview, presence: true
  
  
end
