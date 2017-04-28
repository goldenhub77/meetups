class Meetup < ActiveRecord::Base
  has_many :meetup_members
  has_many :users, through: :meetup_members

  validates :name, presence: true, uniqueness: true
  validates :location, presence: true
  validates :creator, presence: true
  validates :description, presence: true, length: { maximum: 400 }
  validates :start_time, presence: true
  validates :end_time, presence: true

end
