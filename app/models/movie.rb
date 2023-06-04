class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :liking_users, through: :favorites, source: :user

  validates :name, presence: true
  validates :year, presence: true
  validates :overview, presence: true

  # ランサックを使って検索
  def self.ransackable_attributes(auth_object = nil)
    ["genre_name", "name", "overview"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["genre_name", "name", "overview"]
  end

  # APIからデータを直接カラムに保存する
  def self.create_with_api(movie)
      movie = Movie.new(
      name: movie['title'],
      year: movie['release_date'],
      genre_name: movie["genres"][0]["name"],
      image: movie['poster_path'],
      overview: movie['overview'],
      runtime: movie['runtime'],
      )
      movie.save
  end
end
