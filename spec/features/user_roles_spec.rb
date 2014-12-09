require 'rails_helper'

feature "User Roles" do

  describe "a user that doesn't have a role" do
    it "should act as a patron" do
      user = User.create({
        email: "test-user@test.com",
        password: 'AV#rrySecur3Pa$$word',
        password_confirmation: 'AV#rrySecur3Pa$$word',
        confirmed_at: Time.now
      })
      visit new_user_session_path
      fill_in :user_email, with: 'test-user@test.com'
      fill_in :user_password, with: 'AV#rrySecur3Pa$$word'
      click_button 'Sign in'
      visit '/'
      expect(page).to_not have_content("Show Orders")
      expect(page).to_not have_content("Setup Menu")
    end
  end

  describe "a server" do
    it "should see customers orders" do
      user = User.create({
        email: "test-user@test.com",
        password: 'AV#rrySecur3Pa$$word',
        password_confirmation: 'AV#rrySecur3Pa$$word',
        confirmed_at: Time.now,
        role: "server"
      })
      visit new_user_session_path
      fill_in :user_email, with: 'test-user@test.com'
      fill_in :user_password, with: 'AV#rrySecur3Pa$$word'
      click_button 'Sign in'
      visit '/'
      expect(page).to have_content("Show Orders")
    end
  end

  describe "a restaurant admin" do
    before do
      user = User.create({
        email: "test-user@test.com",
        password: 'AV#rrySecur3Pa$$word',
        password_confirmation: 'AV#rrySecur3Pa$$word',
        confirmed_at: Time.now,
        role: "admin"
      })
      visit new_user_session_path
      fill_in :user_email, with: 'test-user@test.com'
      fill_in :user_password, with: 'AV#rrySecur3Pa$$word'
      click_button 'Sign in'
    end

    it "should see setup menu" do
      visit '/'
      expect(page).to have_content("Setup Menu")
    end

    it "should see customers orders" do
      visit '/'
      expect(page).to have_content("Show Orders")
    end
  end


end
