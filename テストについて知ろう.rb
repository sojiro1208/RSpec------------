テストコード：動作を確認するためのコードを書き、実行すると自動で確認する。
  Rspec：RybyのテストコードのGem
  gem 'rspec-rails', '~> 4.0.0'
  
  正常系：ユーザーが開発者の意図する操作を行った際の挙動を確認する。
  異常系：ユーザーが開発者の意図しない操作を行った際の挙動を確認する。

  単体テスト：モデルやコントローラーなどの機能ごとに問題がないか確かめる。
  統合テスト：ブラウザで操作する一連の流れを再現し、問題がないか確かめる。


  rails helper：railsのテストを実行する時、共通の設定を書くファイル
  [例]：rails g rspec:model user → spec/models/user_spec.rb

  describe：テストコードのグループ分けを行うメソッド
    [例]：入れ子構造も可能
    describe 'ユーザー新規登録' do
       # ユーザー新規登録についてのテストコードを記述します  
    end

  it：describe同様グループ分けを行うメソッドdescribeに記述した機能において、どのような状況のテストを行うかを明記する
  
  example：itで分けたグループのこと
  [例]
  describe 'ユーザー新規登録' do
    it 'nicknameが空では登録できない' do
      # nicknameが空では登録できないテストコードを記述します
    end
    it 'emailが空では登録できない' do
      # emailが空では登録できないテストコードを記述します
    end
  end

  bundle execコマンド：Gemの依存関係を整理するコマンド

  rspecコマンド：Rspecのテストコードを実行するコマンド
  [例]：bundle exec rspec spec/models/user_spec.rb 

  valid?：バリデーションを実行させてエラーがあるかを判断する。
   エラーがない時はtrue、ある時はfalse、エラー内容を示すメッセージを生成する
   [例]：user.valid?

  expectation：懸賞で得られた挙動が想定通りなのかを確認する。「expect().to matcher()」

  matcher：「expectの引数」と「想定した挙動」が一致しているかを判断する。
    include：「expectの引数」に「includeの引数」が含まれているかの確認
    【例】includeマッチャのテストコード
      describe 'フルーツ盛り合わせ' do
        it 'フルーツ盛り合わせにメロンが含まれている' do
          expect(['りんご', 'バナナ', 'ぶどう', 'メロン']).to include('メロン')
        end
      end

    eq：「expectの引数」と「eqの引数」が等しいことを確認する
    【例】eqマッチャのテストコード
      describe '加算' do
        it '1 + 1の計算結果は2と等しい' do
          expect(1 + 1).to eq(2)
        end
      end
  
  errors：インスタンスにエラーを示す情報がある場合、その内容を返す。「rails c」で確認

  full_message：エラーの内容からエラーメッセージを配列として取り出すメソッド
  【例】ターミナル：user.errors.full_messagesと記述する
    # 上記の例に続けて以下を実行すると、エラーメッセージが表示される
    [4] pry(main)> user.errors.full_messages
    => ["Nickname can't be blank"]