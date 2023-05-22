require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { User.create(name: 'Taro') }
    let(:movie) { Movie.create(name: 'Example Movie') }

    context 'bodyカラム' do
      it '2文字以上であること' do
        review = Review.new(user: user, movie: movie, body: 'A')
        expect(review.valid?).to eq false
        expect(review.errors[:body]).to include('は2文字以上で入力してください')
      end

      it '500文字以下であること' do
        review = Review.new(user: user, movie: movie, body: 'A' * 501)
        expect(review.valid?).to eq false
        expect(review.errors[:body]).to include('は500文字以内で入力してください')
      end
    end

    context 'rateカラム' do
      it '存在すること' do
        review = Review.new(user: user, movie: movie, rate: nil)
        expect(review.valid?).to eq false
        expect(review.errors[:rate]).to include('を入力してください')
      end
    end
  end
end
