class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  # validates :movie_id, uniqueness: {scope: :user_id}
  validates_uniqueness_of :movie_id, scope: :user_id
end
