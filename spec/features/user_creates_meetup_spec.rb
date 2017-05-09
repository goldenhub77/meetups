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

    expect(page).to have_content("Signed in as Sean Sign Out Start a new Meetup Name Name is required! Location Location is required! Starts at? Format: m/d/yyyy Format: h:m(am or pm) Ends at? Format: m/d/yyyy Format: h:m(am or pm) Description Description is required! Submit Reset")

    fill_in('name', with: 'Starcraft Competition')
    fill_in('location', with: 'Providence, RI')
    fill_in('start_date', with: '06/05/2017')
    fill_in('start_time', with: '3:30pm')
    fill_in('end_date', with: '06/06/2017')
    fill_in('end_time', with: '11:00pm')
    fill_in('description', with: 'Join for a weekend of fun battling friends in a the very popular realtime strategy game Starcraft II')

    click_button('Submit')

    expect(page).to have_content("Sign Out Meetup saved successfully! ✕ Starcraft Competition Join for a weekend of fun battling friends in a the very popular realtime strategy game Starcraft II Providence, RI Begins: Mon Jun 5, 2017 at 3:30PM Ends: Tue Jun 6, 2017 at 11:00PM Started by: jarlax4 0 members joined")

  end

  scenario "User signed out and should not see a Create Meetup button" do
    expect(page).not_to have_selector("new-meetup-link")
  end

  scenario "User signs in and unsuccessfully creates a Meetup" do
    sign_in_as user
    click_on("Create Meetup")

    expect(page).to have_content("Sign Out Start a new Meetup Name Name is required! Location Location is required! Starts at? Format: m/d/yyyy Format: h:m(am or pm) Ends at? Format: m/d/yyyy Format: h:m(am or pm) Description Description is required! Submit Reset")

    fill_in('name', with: 'Starcraft Competition')
    fill_in('location', with: 'Providence, RI')
    fill_in('start_date', with: '06-05-2017')
    fill_in('start_time', with: '3:3pm')
    fill_in('end_date', with: '06-06-017')
    fill_in('end_time', with: '11:0pm')
    fill_in('description', with: 'Join for a weekend of fun battling friends in a the very popular realtime strategy game Starcraft')

    click_button('Submit')

    expect(page).to have_content("Sign Out Meetup not saved - Start date can't be blank, End date can't be blank ✕ Start a new Meetup Name Name is required! Location Location is required! Starts at? Format: m/d/yyyy Format: h:m(am or pm) Ends at? Format: m/d/yyyy Format: h:m(am or pm) Description Join for a weekend of fun battling friends in a the very popular realtime strategy game Starcraft Description is required! Submit Reset")

  end
end
