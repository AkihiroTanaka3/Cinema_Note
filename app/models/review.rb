class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  # has_many :comments, dependent: :destroy
  
  validates :body, length: { minimum: 2, maximum:500 }
end
