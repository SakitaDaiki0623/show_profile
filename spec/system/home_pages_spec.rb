require 'rails_helper'

RSpec.describe "HomePages", type: :system do

  context 'ホームページにアクセス', focus: true do
    before { visit root_path }
    it 'slackログインボタンが表示されていること' do
      expect(page).to have_content('Slackログイン'), '「Slackログイン」ボタンが表示されていません'
    end

    it 'フッターが表示されていること' do
      expect(page).to have_content('プロフちゃんとは'), 'プロフちゃんとはが表示されていません'
      expect(page).to have_content('利用規約'), '「利用規約」が表示されていません'
    end

    it 'タイトルが「プロフちゃん」であること' do
      expect(page).to have_title('プロフちゃん'), '意図したタイトルが表示されていません'
    end
  end

  describe 'ログイン前' do
    context 'プロフィール新規作成画面にアクセス' do
      before { visit new_profile_path }
      it 'ホームページにリダイレクトされること' do
        expect(current_path).to eq(root_path), 'ホームページにリダイレクトされていません'
      end
    end

    context 'プロフィール一覧画面にアクセス' do
      before { visit new_profile_path }
      it 'ホームページにリダイレクトされること' do
        expect(current_path).to eq(root_path), 'ホームページにリダイレクトされていません'
      end
    end
  end
end
