1.検証したいモデルのインスタンスを生成する
2.生成したインスタンスがどのような状況であればいいかを記述する
  
  be_valid：正常系のエクスペクテーションで使う。valid?の返り血がtrueであることを期待するマッチャ
    [例]：spec/models/user_spec.rb
      it 'nicknameが6文字以下であれば登録できる' do
        @user.nickname = 'aaaaaa'
        expect(@user).to be_valid
      end

    [例]spec/models/user_spec.rb
      it 'passwordとpassword_confirmationが6文字以上であれば登録できる' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        expect(@user).to be_valid
      end
    
      ターミナル： bundle exec rspec spec/models/user_spec.rb 

  context：特定の条件を指定してグループ分けを行う。
    [例]
    describe 'ユーザー新規登録' do
      context '新規登録できるとき' do
        it 'nicknameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
        end
      end
      context '新規登録できないとき' do
        it 'nicknameが空では登録できない' do
        end
      end
    end