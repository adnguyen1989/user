class User < ApplicationRecord
  before_create :generate_authentication_token!, :generate_open_id!, :generate_confirmation_token!

  validates :first_name, presence: true, on: :create
  validates :first_name, length: { in: 1..128 }

  validates :last_name, presence: true, on: :create
  validates :last_name, length: { in: 1..128 }

  validates :email, email: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, presence: true, on: :create

  validates :password, presence: true, if: :should_validate_password?
  validates :password, length: { minimum: 6 }, if: :should_validate_password?

  attr_accessor :updating_password

  has_secure_password

  private

    # make this work later due to failing Rspec test
    def should_validate_password?
      updating_password || new_record?
    end

    def generate_authentication_token!
      if !self.authentication_token
        begin
          self.authentication_token = SecureRandom.base64(64)
        end while self.class.exists?(authentication_token: self.authentication_token)
      end
    end

    def generate_open_id!
      if !self.open_id
        begin
          self.open_id = SecureRandom.base64(64)
        end while self.class.exists?(open_id: self.open_id)
      end
    end

    def generate_confirmation_token!
      if !self.confirmation_token
        begin
          self.confirmation_token = SecureRandom.base64(64)
        end while self.class.exists?(confirmation_token: self.confirmation_token)
      end
    end
end
