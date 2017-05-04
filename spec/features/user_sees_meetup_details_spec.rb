require 'spec_helper'

feature "User visits meetup details" do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:meetup) { Meetup.create(
    name: "Helicopter Ride30",
    location: "NYC",
    creator: "john_smith88",
    description: "take a ride above the city",
    start_time: "02-02-02 12:00",
    end_time: "02-02-02 13:00") }

  before(:each) do
    visit '/meetups'
  end


  scenario "No user signed in clicks on a meetup" do
    click_on("Helicopter Ride30")
    expect(page).to have_content("Meetups in Space Sign In Please sign in, no user logged in.")
  end

  scenario "User logged in clicks on a meetup" do
    sign_in_as user
    click_on("Helicopter Ride30")
    expect(page).to have_content("Sign Out Helicopter Ride30 take a ride above the city NYC Begins: 02/02/02 12:00PM Ends: 02/02/02 01:00PM Started by: john_smith88 Members Joined: 0")
  end
end
