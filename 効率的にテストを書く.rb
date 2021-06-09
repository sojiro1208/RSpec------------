FactoryBot：インスタンスをまとめることができるGem
gem 'factory_bot_rails'
[例]：spec/factories/users.rb
  FactoryBot.define do
    factory :user do
      nickname              {'test'}
      email                 {'test@example'}
      password              {'000000'}
      password_confirmation {password}
    end
  end

  build：ActiveRecordのnewメソッドと同じ意味を持つ
  【例】
    # FactoryBotを利用しない場合
    user = User.new(nickname: 'test', email: 'test@example', password: '000000', password_confirmation: '00000000')
    # FactoryBotを利用する場合
    user = FactoryBot.build(:user)

  [例]spec/models/user_spec.rb
    require 'rails_helper'
    RSpec.describe User, type: :model do
      describe 'ユーザー新規登録' do
        it 'nicknameが空では登録できない' do
          user = FactoryBot.build(:user)  # Userのインスタンス生成
          user.nickname = ''  # nicknameの値を空にする
          user.valid?
          expect(user.errors.full_messages).to include "Nickname can't be blank"
        end
        it 'emailが空では登録できない' do
          user = FactoryBot.build(:user)  # Userのインスタンス生成
          user.email = ''  # emailの値を空にする
          user.valid?
          expect(user.errors.full_messages).to include "Email can't be blank"
        end
      end
    end

  before：テストコードを実行する前にセットアップを行う
  【例】
    require 'rails_helper'
    RSpec.describe User, type: :model do
      before do
        # 何かしらの処理
      end

      describe 'X' do
        it 'Y' do
          # before内の処理が完了してから実行される
        end
        it 'Z' do
          # before内の処理が完了してから実行される
        end
      end
    end

    [例]spec/models/user_spec.rb
      require 'rails_helper'
      RSpec.describe User, type: :model do
        before do
          @user = FactoryBot.build(:user)
        end

        describe 'ユーザー新規登録' do
          it 'nicknameが空では登録できない' do
            @user.nickname = ''
            @user.valid?
            expect(@user.errors.full_messages).to include "Nickname can't be blank"
          end
          it 'emailが空では登録できない' do
            @user.email = ''
            @user.valid?
            expect(@user.errors.full_messages).to include "Email can't be blank"
          end
        end
      end

  Faker：ランダムな値を生成するGem。アドレス、人名、パスワードなど
  gem 'faker'
  [例]spec/factories/users.rb
    FactoryBot.define do
      factory :user do
        nickname              {Faker::Name.initials(number: 2)}
        email                 {Faker::Internet.free_email}
        password              {Faker::Internet.password(min_length: 6)}
        password_confirmation {password}
      end
    end