class CreateUserMeetups < ActiveRecord::Migration
  def change
    create_join_table :meetups, :users
  end
end
