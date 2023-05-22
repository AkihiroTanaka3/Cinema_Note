require 'rails_helper'

RSpec.describe "Admin_Movies", type: :system do
  describe 'トップ画面のテスト' do
  before do
    visit admin_root_path
  end
end
describe "保存画面のテスト" do
  before do
  context '表示の確認' do
  it 'displays The Super Mario Bros. Movie' do
    visit "/admin/movies/502356"
          expect(page).to have_content("ザ・スーパーマリオブラザーズ・ムービー")
          expect(page).to have_content("公開年：2023-04-05")
          expect(page).to have_content("ジャンル：アニメーション")
          expect(page).to have_content("上映時間：92分")
          expect(page).to have_content("ニューヨークで配管工を営む双子の兄弟マリオとルイージ。謎の土管で迷いこんだのは、魔法に満ちた新世界。はなればなれになってしまった兄弟が、絆の力で世界の危機に立ち向かう。")
          click_button '保存する'
          expect(page).to admin_movise_path
        end
      end
    end
  end
end
describe "一覧画面のテスト" do
  before do
    context '表示の確認' do
      it '保存されたものが表示されているか' do
        expect(page).to have_content movie.name
      end
    end
  end
end
