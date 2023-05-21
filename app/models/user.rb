class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :liked_movies, through: :favorites, source: :movie

  validates :name, presence: true, length: {maximum: 10}, uniqueness: true
  validates :introduction, length: {maximum: 20 }

  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  def guest?
    email == 'guest@example.com'
  end

  def likes?(movie)
    self.favorites.exists?(movie_id: movie.id)
  end

  def admin?
    admin # モデルの属性として定義されている場合、そのまま返す
  end
end
