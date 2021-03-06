# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Example:
#
#   Person.create(first_name: 'Eric', last_name: 'Kelly')
require 'Date'

User.create(provider: "testprovider", uid: 22, username: "goldenhub99", name: "Sean", email: "test@ao.com", avatar_url: "https://url.com")
User.create(provider: "testprovider2", uid: 255, username: "hellocode2", name: "Tim", email: "test@ao.com", avatar_url: "https://url.com")
User.create(provider: "testprovider3", uid: 123, username: "mynameis123", name: "John", email: "test@ao.com", avatar_url: "https://url.com")

date = DateTime.now

Meetup.create(name: "MMO in the park", location: "central park, NYC", creator: "goldenhub77", description: "take a walk in the park and battle with friends", start_date: date, end_date: date.new_offset('+03:00'))
Meetup.create(name: "video game lan party", location: "my house", creator: "goldenhub77", description: "take a walk in the park and battle with friends", start_date: date, end_date: date.new_offset('+03:00'))
Meetup.create(name: "sky diving group", location: "40,000 ft up over grand canyon", creator: "goldenhub77", description: "take a walk in the park and battle with friends", start_date: date, end_date: date.new_offset('+03:00'))


MeetupMember.create(user_id: 2, meetup_id: 1)
MeetupMember.create(user_id: 3, meetup_id: 1)
MeetupMember.create(user_id: 2, meetup_id: 2)
MeetupMember.create(user_id: 2, meetup_id: 3)
