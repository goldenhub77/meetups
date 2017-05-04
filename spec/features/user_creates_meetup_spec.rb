require 'spec_helper'

feature "User creates a meetup" do

  let!(:user) { FactoryGirl.create(:user) }

  before(:each) do
    visit '/meetups'
  end

  scenario "User signed out and should not see a Create Meetup button" do
    expect(page).not_to have_selector("new-meetup-link")
  end

  scenario "User signed in and clicks on Create Meetup" do
    sign_in_as user
    click_on("Create Meetup")
    expect(page).to have_content("Sign Out Start a new Meetup Name your meetup Where is it located? When will it start? When will it end? What will you be doing?")
  end

  scenario "User fills out form" do
    
  end
end
