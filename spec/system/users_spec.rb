require 'rails_helper'

describe 'ユーザー機能', type: :system do

  describe '新規作成機能' do
    # let(:params) { {name: name, email: email, password: password, password_confirmation: password_confirmation} }
    let(:name) { 'カエル' }
    let(:email) { 'kaeru@mail.com' }
    let(:password) { 'password' }
    let(:password_confirmation) { 'password' }
    
    before do
      visit new_user_path
      fill_in 'Name', with: name
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      fill_in 'Confirmation', with: password_confirmation
      click_button 'Create my account'
    end

    context '必要条件を満たしている' do
      it '正常に登録される' do
        expect(page).to have_selector '.alert-info', text: 'Please check your email to activate your accout.'
      end
    end

    context '全項目が空欄' do
      let(:name) { '' }
      let(:email) { '' }
      let(:password) { '' }
      let(:password_confirmation) { '' }
      it 'エラーになる' do
        expect(page).to have_selector '#error_explanation li', text: "Name can't be blank"
        expect(page).to have_selector '#error_explanation li', text: "Email can't be blank"
        expect(page).to have_selector '#error_explanation li', text: "Email is invalid"
        expect(page).to have_selector '#error_explanation li', text: "Password can't be blank"
      end
    end

    context '確認パスワードが異なる' do
      let(:password) { 'password' }
      let(:password_confirmation) { 'foobar' }

      it 'エラーになる' do
        expect(page).to have_selector '#error_explanation li', text: "Password confirmation doesn't match Password"
      end
    end

    context 'メールアドレスが既に存在する' do
      # FactoryBot.create(:user)
      let(:email) { 'test@mail.com' }

      it 'エラーになる' do
        expect(page).to have_selector '#error_explanation li', text: 'Email has already been taken'
      end
    end

    context 'メールアドレスの値が不正' do
      let(:email) { 'kaeru@mailcom' }

      it 'エラーになる' do
        expect(page).to have_selector '#error_explanation li', text: 'Email is invalid'
      end
    end
    
  end

  
end