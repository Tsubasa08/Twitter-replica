require 'rails_helper'

describe '投稿機能', type: :system do
  let(:user) { FactoryBot.create(:user) }

  describe '一覧表示機能' do
    let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@mail.com') }
    let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@mail.com') }

    before do
      FactoryBot.create(:micropost, content: '最初の投稿', user: user_a)
      visit login_path
      fill_in 'Email', with: login_user.email
      fill_in 'Password', with: login_user.password
      click_button 'Log in'
    end

    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }
      it 'ユーザーAが作成した投稿が表示される' do
        expect(page).to have_content '最初の投稿'
      end
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }

      it 'ユーザーAが作成した投稿が表示される' do
        expect(page).to have_no_content '最初の投稿'
      end
    end
    
  end


  describe '新規作成機能' do
    let(:post_content) { '新規作成のテストを書く' }

    before do
      visit login_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'

      visit root_path
      fill_in 'micropost_content', with: post_content #textareaのid
      click_button 'Post'
    end

    context '投稿内容を入力したとき' do
      it '正常に登録される' do
        expect(page).to have_selector '.alert-success', text: 'Micropost created!'
      end
    end

    context '投稿内容を入力しなかったとき' do
      let(:post_content) { '' }

      it 'エラーになる' do
        expect(page).to have_selector '#error_explanation li', text: "Content can't be blank"
      end
    end
  end

end