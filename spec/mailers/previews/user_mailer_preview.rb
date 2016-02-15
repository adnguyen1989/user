# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # http://localhost:3000/rails/mailers/user_mailer/signup_confirmation
  def signup_confirmation
    UserMailer.signup_confirmation(User.fourth)
  end

end
