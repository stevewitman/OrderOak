require 'rails_helper'

feature "User Login" do

  describe "when user has no account" do
    it "should allow a user to sign up" do
      visit new_user_registration_path
      fill_in :user_email, with: 'testuser@test.com'
      fill_in :user_password, with: 'NotAVerySecurePassword'
      fill_in :user_password_confirmation, with: 'NotAVerySecurePassword'
      click_button 'Sign Up'
      expect(page).to have_content "A message with a confirmation link has been sent to your email address. Please follow the link to activate your account."
      expect(User.count).to be > 0
    end
  end

  describe "when a user has already signed up" do
    before do
      User.create({
        email: "test-user@test.com",
        password: 'AV#rrySecur3Pa$$word',
        password_confirmation: 'AV#rrySecur3Pa$$word',
        confirmed_at: Time.now
      })
    end

    it "should allow a user to log in" do
      visit new_user_session_path
      fill_in :user_email, with: 'test-user@test.com'
      fill_in :user_password, with: 'AV#rrySecur3Pa$$word'
      click_button 'Sign in'
      expect(page).to have_content "Signed in successfully."
      expect(page).to have_content "Sign Out"
    end

    describe "When a user has already signed in" do
      it "should display a 'Sign Out' link" do
        visit new_user_session_path
        fill_in :user_email, with: 'test-user@test.com'
        fill_in :user_password, with: 'AV#rrySecur3Pa$$word'
        click_button 'Sign in'

        visit '/'
        expect(page).to have_content "Sign Out"
      end
    end

    describe "before a user signs in" do
      it "should display a 'Sign In' link" do
        visit '/'
        expect(page).to have_content "Sign In"
      end
    end
  end
end
