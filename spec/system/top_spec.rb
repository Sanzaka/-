require "rails_helper"

describe "top画面のテスト" do
  before do
    visit root_path
  end

  describe "ログイン前" do
    describe "表示のテスト" do
      it "topリンクがある" do
        expect(page).to have_content "TOP"
      end
      it "ログインリンクがある" do
        expect(page).to have_content "ログイン"
      end
      it "新規登録リンクがある" do
        expect(page).to have_content "新規登録"
      end
      it "ゲストログインがある" do
        expect(page).to have_content "ゲストログイン"
      end
    end
  end

  describe "ログイン後" do
    before do
      @user = FactoryBot.create(:user)
      @user2 = FactoryBot.create(:user)
      sign_in @user
    end

    describe "ユーザーページのテスト" do
      it "ログインは可能か？" do
        visit user_path(@user)
        expect(page).to have_content "ユーザー情報"
      end

      it "ログイン後、上部リンクは変更されているか" do
        expect do
          have_content "ログアウト"
          have_content "TOP"
          have_content "マイページ"
          have_content "マイグループ"
        end
      end

      it "別ユーザーのIDでedit進入時、進入禁止のバリデーションが働くか" do
        visit user_path(@user2)
        click_on "情報変更"
        expect(page).to have_content "閲覧権限がありません"
      end
    end

    describe "グループページのテスト" do
      describe "ワークグループ" do
        before do
          @group = FactoryBot.create(:group)
          @member = FactoryBot.create(:group_member)
        end

        it "グループ作成は可能か" do
          visit new_group_path
          fill_in "session_name", with: "テストグループ"
          choose "session_work_group"
          choose "session_direct_true"
          click_on "グループ作成"
          expect(page).to have_content "グループを作成しました！"
        end

        it "グループページに遷移は可能か" do
          visit group_path(@group)
          expect(page).to have_content "テストグループ"
        end

        it "今日の目標は投稿可能か" do
          visit group_path(@group)
          fill_in "session_target", with: "今日は頑張ります"
          click_on "今日の目標登録"
          expect(page).to have_content "今日の目標を登録しました！"
        end
      end

    end


  end

end