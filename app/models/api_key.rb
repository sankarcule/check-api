class ApiKey < ApplicationRecord
  belongs_to :user
  before_create :generate_access_token
  before_create :set_expiration

  def expired?
    DateTime.now >= self.expires_at
  end

  private
  def generate_access_token
    begin
      self.token = SecureRandom.hex
    end while self.class.exists?(token: token)
  end

  def set_expiration
    self.expires_at = DateTime.now+30
  end
end
