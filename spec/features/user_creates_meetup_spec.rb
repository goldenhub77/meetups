require 'spec_helper'

feature "User creates a meetup" do

  let!(:user) { FactoryGirl.create(:user) }

  before(:each) do
    visit '/meetups'
  end

  scenario "User signed out and should not see a Create Meetup button" do
    expect(page).not_to have_selector("new-meetup-link")
  end

  scenario "User signs in and successfully creates a Meetup" do
    sign_in_as user
    click_on("Create Meetup")

    expect(page).to have_content("Sign Out Start a new Meetup Name Name is required! Location Location is required! Starts at? Start Date/Time Ends at? End Date/Time is required! Description Description is required! Submit Reset")

    fill_in('name', with: 'Starcraft II Competition')
    fill_in('location', with: 'Providence, RI')
    fill_in('start_date', with: '6/20/17')
    fill_in('start_time', with: '3:30pm')
    fill_in('end_date', with: '6/22/17')
    fill_in('end_time', with: '11:00pm')
    fill_in('description', with: 'Join for a weekend of fun battling friends in a the very popular realtime strategy game Starcraft II')

    click_button('Submit')

    
  end
end
