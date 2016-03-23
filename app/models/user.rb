class User < ActiveRecord::Base
  has_many :channels
  has_many :transports
  
  validates :name, presence: true, uniqueness: true
  validates :token, presence: true, uniqueness: true

  before_validation :generate_token, on: :create

  private

  def generate_token
    self.token ||= SecureRandom.uuid
  end
end
