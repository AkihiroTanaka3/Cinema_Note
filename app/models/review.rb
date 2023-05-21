class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  
  validates :body, length: { minimum: 2, maximum:500 }
  validates :rate, presence: true
end
