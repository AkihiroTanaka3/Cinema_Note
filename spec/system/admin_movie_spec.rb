require 'rails_helper'

RSpec.describe "Admin_Movies", type: :system do
  let(:admin) { create(:admin) }
  describe 'トップ画面のテスト' do
      before do
        visit new_admin_session_path

        fill_in 'admin[email]', with: admin.email
        fill_in 'admin[password]', with: admin.password
        click_button 'ログイン'
      end
    before do
      visit admin_root_path
    end
    
    context '表示の確認' do
      it 'displays The Super Mario Bros. Movie' do
        visit "/admin/movies/502356"
        expect(page).to have_content("ザ・スーパーマリオブラザーズ・ムービー")
        expect(page).to have_content("公開年：2023-04-05")
        expect(page).to have_content("ジャンル：アニメーション")
        expect(page).to have_content("上映時間：92分")
        expect(page).to have_content("ニューヨークで配管工を営む双子の兄弟マリオとルイージ。謎の土管で迷いこんだのは、魔法に満ちた新世界。はなればなれになってしまった兄弟が、絆の力で世界の危機に立ち向かう。")
        click_button '保存する'
        expect(page).to have_current_path(admin_movies_path)
      end
    end
  end
end
