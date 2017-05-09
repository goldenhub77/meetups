require 'spec_helper'

feature "User clicks join meetup in meetup details" do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:meetup) { Meetup.create(
    name: "Helicopter Ride31",
    location: "NYC",
    creator: "john_smith88",
    description: "take a ride above the city",
    start_date: "02-02-02 12:00",
    end_date: "02-02-02 13:00") }

    before :each do
      visit '/'
    end

  scenario "User clicks on join meetup signed out" do
    click_on("Helicopter Ride31")
    click_on("Join Meetup")
  end

  scenario "User clicks on join meetup signed in" do
    sign_in_as user
    click_on("Helicopter Ride31")
    click_on("Join Meetup")
  end
end
