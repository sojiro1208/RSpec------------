モデル       ：インスタンスを生成し、それがモデルに規定したどおりの挙動になるか（たとえば、バリデーションが正しく働くか）を確かめる
コントローラー：あるアクションにリクエストを送ったとき、想定通りのレスポンスが生成されるかどうかを確かめる

  Request Spec：コントローラー特化のテストコード
  rails g rspec:request tweetsでディレクトリを作成
  create：テスト用のDBに値が保存される。終了するたびに保存された値が消える
  [例]：spec/requests/tweets_spec.rb
    require 'rails_helper'
    describe TweetsController, type: :request do
 
      before do
        @tweet = FactoryBot.create(:tweet)
      end
 
       describe 'GET #index' do
        it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do 
          ①get root_path
          binding.pry  #後に消す
          expect(response.status).to eq 200
        end
        it 'indexアクションにリクエストするとレスポンスに投稿済みのツイートのテキストが存在する' do 
          ②get root_path
          binding.pry
          expect(response.body).to include(@tweet.text)
        end
        it 'indexアクションにリクエストするとレスポンスに投稿済みのツイートの画像URLが存在する' do 
          get root_path
          expect(response.body).to include(@tweet.image)
        end
        it 'indexアクションにリクエストするとレスポンスに投稿検索フォームが存在する' do 
          get root_path
          expect(response.body).to include('投稿を検索する')
        end
      end
    end

    ターミナル：bundle exec rspec spec/requests/tweets_spec.rb

  ①get：どこのパスにリクエストを送りたいかを記述する

  response：リクエストに対するレスポンスが含まれる。
  HTTPステータスコード：どのような結果になったかを示す。
  100~	処理の継続中
  200~	処理の成功
  300~	リダイレクト
  400~	クライアントのエラー
  500~	サーバーのエラー

  status：response.statusと実行すると、そのレスポンスのステータスコードを出力できる

  ②body：response.bodyと記述すると、ブラウザに表示されるHTMLの情報を抜き出す

  [showアクションのテストコード]
  describe 'GET #show' do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get tweet_path(@tweet)
      expect(response.status).to eq 200
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みのツイートのテキストが存在する' do 
      get tweet_path(@tweet)
      expect(response.body).to include(@tweet.text)
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みのツイートの画像URLが存在する' do 
      get tweet_path(@tweet)
      expect(response.body).to include(@tweet.image)
    end
    it 'showアクションにリクエストするとレスポンスにコメント一覧表示部分が存在する' do 
      get tweet_path(@tweet)
      expect(response.body).to include('＜コメント一覧＞')
    end
  end 