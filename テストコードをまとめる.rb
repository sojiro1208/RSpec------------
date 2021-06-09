サポートモジュール：Rspecに用意されているメソッドをまとめる機能
  spec/support/sign_in_support.rb を作成。
  [記述内容]
  module SignInSupport
    def sign_in(user)
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
    end
  end
  
サポートモジュールを使うために
・rails_helper.rbのコメントアウトを外す
    Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }
    コメントアウトを外す！

・モジュールを設定する。
    同じファイルの「Rspec.configureの中に記述する」
    config.include SignInSupport

これでOK！

今までのログインをするというテストコードを「sign_in(@user)」に変更！