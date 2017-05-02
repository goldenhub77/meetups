require 'spec_helper'

describe Meetup do
  describe ".create" do
    context "name, location, creator, description, start_time, end_time all require input. Name must be unique and description max length of 400" do
      let(:meetup_fail) { Meetup.create() }
      let(:meetup_pass) { Meetup.create(name: "walk in the park", location: "NYC", creator: "jamjam77", description: "late stroll in the park with a group for exercise", start_time: "01-01-01 0:00:00", end_time: "01-01-01 02:00:00") }

      it "should return object of errors as a string for meetup_fail and empty object for meetup_pass" do
        expect(meetup_fail.errors.messages.to_s).to eq("{:name=>[\"can't be blank\"], :location=>[\"can't be blank\"], :creator=>[\"can't be blank\"], :description=>[\"can't be blank\"], :start_time=>[\"can't be blank\"], :end_time=>[\"can't be blank\"]}")
        expect(meetup_pass.errors.messages.to_s).to eq("{}")
      end
    end

    describe ".capitalize_name" do
      context "before saving to database all words in name should be capitalized" do
        let!(:lower_case_meetup) { Meetup.create(name: "lan party extravaganza", location: "NYC", creator: "jamjam77", description: "late stroll in the park with a group for exercise", start_time: "01-01-01 0:00:00", end_time: "01-01-01 02:00:00") }
        let!(:mixed_case_meetup) { Meetup.create(name: "Club night in the big City", location: "NYC", creator: "jamjam77", description: "late stroll in the park with a group for exercise", start_time: "01-01-01 0:00:00", end_time: "01-01-01 02:00:00") }
        let!(:capitalized_meetup) { Meetup.create(name: "Glide Through The Tropics", location: "NYC", creator: "jamjam77", description: "late stroll in the park with a group for exercise", start_time: "01-01-01 0:00:00", end_time: "01-01-01 02:00:00") }

        it "should return the title with first letters capitalized of all words" do
          expect(lower_case_meetup.name).to eq("Lan Party Extravaganza")
          expect(mixed_case_meetup.name).to eq("Club Night In The Big City")
          expect(capitalized_meetup.name).to eq("Glide Through The Tropics")
        end
      end
    end
  end
end
