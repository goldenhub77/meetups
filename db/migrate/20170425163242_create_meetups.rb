class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |table|
      table.string :name, null: false
      table.string :location, null: false
      table.string :creator, null: false
      table.text :description, null: false
      table.datetime :start_time, null: false
      table.datetime :end_time, null: false

      table.timestamps null: false
    end
    
    add_index :meetups, :name, unique: true
  end
end
