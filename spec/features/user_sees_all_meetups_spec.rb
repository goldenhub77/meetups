require 'spec_helper'

feature "User visits meetups index" do

  let(:user) { FactoryGirl.create(:user) }
  let(:meetups) { [] }

  before(:each) do
    10.times do
      meetups.push(FactoryGirl.create(:meetup))
    end
    visit '/'
  end

  feature "user is signed out" do
    scenario "user sees all the meetups in alphabetical order" do
      meetups = Meetup.all.sort { |a, b| a.name <=> b.name }
      check_result = ""
      meetups.each do |meetup|
        check_result += "#{meetup.name} " 
      end
      expect(page).to have_content(check_result)
    end
  end

  feature "user is signed in" do

    scenario "user sees all the meetups in alphabetical order" do
      sign_in_as user
      Meetup.all.each do |meetup|
        expect(page).to have_content(meetup.name)
      end
    end
  end
end
