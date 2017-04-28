require 'spec_helper'

describe MeetupMember do
  describe ".create" do
    context "user_id, meetup_id is required input" do
      let(:meetup_member_fail) { MeetupMember.create() }
      let(:meetup_member_pass) { MeetupMember.create(user_id: 1, meetup_id: 2) }
      it "should return object of errors as a string for meetup_fail and empty object for meetup_pass" do
        expect(meetup_member_fail.errors.messages.to_s).to eq("{:user_id=>[\"can't be blank\"], :meetup_id=>[\"can't be blank\"]}")
        expect(meetup_member_pass.errors.messages.to_s).to eq("{}")
      end
    end
  end
end
