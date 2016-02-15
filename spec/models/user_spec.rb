require 'rails_helper'


RSpec.describe User, type: :model do
    before(:each) do
      @user_valid = FactoryGirl.create(:user)
      # allow(@users.each).to receive(:updating_password?).and_return(true)
    end

    it "has a valid factory" do
      expect(@user_valid).to be_valid
    end

    it "has a random authentication_token" do
      base_64_regex = %r{^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=)?$}
      expect(@user_valid.authentication_token).to match base_64_regex
    end

    it "has a random open_id" do
      base_64_regex = %r{^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=)?$}
      expect(@user_valid.open_id).to match base_64_regex
    end

    it "has a random confirmation_token" do
      base_64_regex = %r{^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=)?$}
      expect(@user_valid.confirmation_token).to match base_64_regex
    end

    it "has a unique authentication_token" do
      expect {FactoryGirl.create(:user, authentication_token: @user_valid.authentication_token)}.to raise_error(ActiveRecord::RecordNotUnique)
    end

    it "has a unique open_id" do
      expect {FactoryGirl.create(:user, open_id: @user_valid.open_id)}.to raise_error(ActiveRecord::RecordNotUnique)
    end

    it "has a unique confirmation_token" do
      expect {FactoryGirl.create(:user, confirmation_token: @user_valid.confirmation_token)}.to raise_error(ActiveRecord::RecordNotUnique)
    end

    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_length_of(:last_name) }
    it { should validate_length_of(:last_name) }
    it { should validate_length_of(:password) }
    it { should have_secure_password }
end
