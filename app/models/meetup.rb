class Meetup < ActiveRecord::Base
  has_many :user_meetups
  has_many :users, through: :user_meetups

  validates :name, presence: true, uniqueness: true
  validates :location, presence: true
  validates :creator, presence: true
  validates :description, presence: true, length: { is: 400 }
  validates :start_time, presence: true
  validates :end_time, presence: true

end
