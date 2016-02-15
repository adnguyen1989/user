require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "signup_confirmation" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end
    let(:mail) { UserMailer.signup_confirmation(@user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Sign Up Confirmation")
      expect(mail.to).to eq([@user.email])
      expect(mail.from).to eq([ENV['SIGNUP_CONFIRMATION_EMAIL']])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Sample mail sent.")
    end
  end

end
