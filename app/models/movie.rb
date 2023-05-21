class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :liking_users, through: :favorites, source: :user
  
  validates :name, presence: true
  validates :year, presence: true
  validates :overview, presence: true
  
  def self.ransackable_attributes(auth_object = nil)
    ["genre_name", "name", "overview"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["genre_name", "name", "overview"]
  end
end
