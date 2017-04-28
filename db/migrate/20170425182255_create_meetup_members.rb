class CreateMeetupMembers < ActiveRecord::Migration
  def change
    create_join_table :meetups, :users, table_name: :meetup_members
  end
end
