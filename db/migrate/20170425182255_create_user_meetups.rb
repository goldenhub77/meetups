class CreateUserMeetups < ActiveRecord::Migration
  def change
    create_join_table :meetups, :users, table_name: :user_meetups
  end
end
