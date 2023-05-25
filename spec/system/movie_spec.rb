require 'rails_helper'

RSpec.describe "Movies", type: :system do
    let(:user) { create(:user) }
    context 'ログイン成功のテスト' do
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログインする'
      end

      it 'ログイン後のリダイレクト先が、映画の一覧画面になっている' do
        expect(current_path).to eq '/movies'
      end
    end
    context 'ログイン失敗のテスト' do
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログインする'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/users/sign_in'
      end
    end

  describe "詳細画面のテスト" do
    let(:user) { create(:user) }
    let(:movie) { FactoryBot.create(:movie) }
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログインする'
      end
    it "詳細ページの記述、reviewsフォームの存在を確認する" do
      visit movie_path(movie)
      expect(page).to have_content("閲覧数")
      expect(page).to have_content("お気に入り")
      expect(page).to have_content("公開年")
      expect(page).to have_content("ジャンル")
      expect(page).to have_content("上映時間")
      expect(page).to have_content("評価する")
      expect(page).to have_content("感想を書く")
      expect(page).to have_content("Review list")
      expect(page).to have_field("review[body]")
      expect(page).to have_button("Create Review")
    end
  end
end
  
  describe "マイページのテスト" do
    let(:user) { create(:user) }
    let(:movie) { FactoryBot.create(:movie) }
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログインする'
      end
    it "マイページでユーザーネームが表示されているか、ビュー内の表示があるか確認する" do
      visit user_path(user)
      expect(page).to have_content(user.name)
      expect(page).to have_content(user.introduction)
      expect(page).to have_content("お気に入り")
      expect(page).to have_content("編集する")
      expect(page).to have_content("退会する")
    end
  end