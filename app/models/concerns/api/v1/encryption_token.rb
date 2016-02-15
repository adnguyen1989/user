module Api::V1::EncryptionToken
  extend ActiveSupport::Concern

  def authenticate_confirmation_token(external_token)
    # return User.find_by(confirmation_token: Encryption.decrypt(external_token))
    return User.find_by(confirmation_token: external_token)
  end

  def authenticate_password_reset_token(external_token)
    # return User.find_by(password_reset_token: Encryption.decrypt(external_token))
    return User.find_by(password_reset_token: external_token)
  end
end
