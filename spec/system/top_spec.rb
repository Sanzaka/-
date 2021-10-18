require "rails_helper"

describe "top画面のテスト" do
  before do
    visit root_path
  end

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
  end

end