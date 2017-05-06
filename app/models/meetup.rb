class Meetup < ActiveRecord::Base
  has_many :meetup_members
  has_many :users, through: :meetup_members

  validates :name, presence: true
  validates :location, presence: true
  validates :creator, presence: true
  validates :description, presence: true, length: { maximum: 400 }
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :validate_start_and_end_dates

  before_save :capitalize_name

  def capitalize_name
    capitalized_name = name.split(" ")
    capitalized_name = capitalized_name.map { |part| part.capitalize }
    capitalized_name = capitalized_name.join(" ")
    self.name = capitalized_name
  end

  def validate_start_and_end_dates
    if end_date && start_date
      errors.add(:end_date, "must be greater than start date") if end_date < start_date
    end
  end
end
