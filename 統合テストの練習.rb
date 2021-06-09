System Spec：統合テストを記述するための仕組み。
  Capybara：System Specを記述するために必要なGem
  gem 'capybara', '>= 2.15'
  rails g rspec:system users

  require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path

      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')

      # 新規登録ページへ移動する
      visit new_user_registration_path

      # ユーザー情報を入力する
      fill_in 'Nickname', with: @user.nickname
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password_confirmation

      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)

      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)

      # カーソルを合わせるとログアウトボタンが表示されることを確認する
      expect(
        find('.user_nav').find('span').hover
      ).to have_content('ログアウト')

      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')

    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path

      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')

      # 新規登録ページへ移動する
      visit new_user_registration_path

      # ユーザー情報を入力する
      fill_in 'Nickname', with: ''
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      fill_in 'Password confirmation', with: ''

      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)

      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq user_registration_path
      
    end
  end
end

visit：visit 〇〇_pathと記述。〇〇のページへ実際に遷移することを表現。

page：visitで訪れた先のページの見える分だけの情報が格納されている。
  have_content：expect(page).to have_content('X')と記述。visitで訪れたpageの中に「X」という文字列があるかを判断する。

fill_in：フォームへの入力ができる。fill_in 'フォームの名前', with: '入力する文字列'。
  フォームの名前は検証ツールで確認してね。

  find().click：実際にクリックする「find('クリックしたい要素').click」
  <input type="submit" name="commit" value="Sign up" data-disable-with="Sign up">
  ↓
  find('input[name="commit"]').click

  change：モデルのレコードの数が幾つ変動するかを確認する。
    「expect{ 何かしらの動作 }.to change { モデル名.count }.by(1)」
    何かしらの動作 = 送信ボタンをクリックした時 = find('input[name="commit"]').click


current_path：文字通り、現在いるページのパスを表す。

hover：特定の要素にカーソルを合わせた時の動作を再現できる。
  find('ブラウザ上の要素').hover

have_no_content：文字列が存在しないことを確かめる。