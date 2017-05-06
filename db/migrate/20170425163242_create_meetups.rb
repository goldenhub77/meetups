class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |table|
      table.string :name, null: false
      table.string :location, null: false
      table.string :creator, null: false
      table.text :description, null: false
      table.datetime :start_date, null: false
      table.datetime :end_date, null: false

      table.timestamps null: false
    end
  end
end
