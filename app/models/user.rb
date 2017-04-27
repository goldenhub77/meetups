class User < ActiveRecord::Base
  has_many :user_meetups
  has_many :meetups, through: :user_meetups

  validates :provider, presence: true, uniqueness: true
  validates :uid, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, format: { with: /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i }
  validates :avatar_url, presence: true, format: { with: /([a-zA-Z]+):\/\/(-\.)?(([^\s\/?\.#\-]+|([^\s\/?\.#\-]-[^\s\/?\.#\-]))\.?)+(\/[^\s]*)?/i }

  def self.find_or_create_from_omniauth(auth)
    provider = auth.provider
    uid = auth.uid

    find_or_create_by(provider: provider, uid: uid) do |user|
      user.provider = provider
      user.uid = uid
      user.email = auth.info.email
      user.username = auth.info.name
      user.avatar_url = auth.info.image
    end
  end
end
