require 'spec_helper'

describe Meetup do
  describe ".create" do
    context "name, location, creator, description, start_date, end_date all require input. Description max length of 400" do
      let(:meetup_fail) { Meetup.create() }
      let(:meetup_pass) { Meetup.create(name: "walk in the park", location: "NYC", creator: "jamjam77", description: "late stroll in the park with a group for exercise", start_date: "01-01-01 0:00:00", end_date: "01-01-01 02:00:00") }

      it "should return object of errors as a string for meetup_fail and empty object for meetup_pass" do
        expect(meetup_fail.errors.messages.to_s).to eq("{:name=>[\"can't be blank\"], :location=>[\"can't be blank\"], :creator=>[\"can't be blank\"], :description=>[\"can't be blank\"], :start_date=>[\"can't be blank\"], :end_date=>[\"can't be blank\"]}")
        expect(meetup_pass.errors.messages.to_s).to eq("{}")
      end
    end

    describe ".capitalize_name" do
      context "before saving to database all words in name should be capitalized" do
        let!(:lower_case_meetup) { Meetup.create(name: "lan party extravaganza", location: "NYC", creator: "jamjam77", description: "late stroll in the park with a group for exercise", start_date: "01-01-01 0:00:00", end_date: "01-01-01 02:00:00") }
        let!(:mixed_case_meetup) { Meetup.create(name: "Club night in the big City", location: "NYC", creator: "jamjam77", description: "late stroll in the park with a group for exercise", start_date: "01-01-01 0:00:00", end_date: "01-01-01 02:00:00") }
        let!(:capitalized_meetup) { Meetup.create(name: "Glide Through The Tropics", location: "NYC", creator: "jamjam77", description: "late stroll in the park with a group for exercise", start_date: "01-01-01 0:00:00", end_date: "01-01-01 02:00:00") }

        it "should return the title with first letters capitalized of all words" do
          expect(lower_case_meetup.name).to eq("Lan Party Extravaganza")
          expect(mixed_case_meetup.name).to eq("Club Night In The Big City")
          expect(capitalized_meetup.name).to eq("Glide Through The Tropics")
        end
      end
    end

    describe ".validate_start_and_end_dates" do
      context "before saving to database end_date should be greater than start_date" do
        let!(:meetup_fail_1) { Meetup.new(name: "lan party extravaganza", location: "NYC", creator: "jamjam77", description: "late stroll in the park with a group for exercise", start_date: "01-02-01 0:00:00", end_date: "01-01-01 02:00:00") }
        let!(:meetup_fail_2) { Meetup.new(name: "Club night in the big City", location: "NYC", creator: "jamjam77", description: "late stroll in the park with a group for exercise", start_date: "01-02-01 1:00:00", end_date: "01-01-01 02:00:00") }
        let!(:meetup_fail_3) { Meetup.new(name: "Glide Through The Tropics", location: "NYC", creator: "jamjam77", description: "late stroll in the park with a group for exercise", start_date: "01-01-01 1:00:00", end_date: "01-01-01 00:00:00") }

        it "should return error if end_date is less than start_date" do
          meetup_fail_1.save
          meetup_fail_2.save
          meetup_fail_3.save
          expect(meetup_fail_1.valid?).to eq(false)
          expect(meetup_fail_2.valid?).to eq(false)
          expect(meetup_fail_3.valid?).to eq(false)
        end
      end
    end
  end
end
