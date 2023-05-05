class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :revi
  
  validates :body, length: { minimum: 2, maximum: 250 }
end
