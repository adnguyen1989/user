require 'rails_helper'
require 'spec_helper'

RSpec.describe Api::V1::RegistrationsController, type: :controller do
  describe 'RegistrationsController#create' do
    before(:each) do
      @user_attributes = FactoryGirl.attributes_for(:user)
      # pp @user_attributes
    end

    context 'it successfully creates a user' do
      before(:each) do
        post :create, params: { user: @user_attributes }, format: :json
        @user_response = json_response[:data]
        @user = User.find_by(id: @user_response[:id])
      end

      it 'renders the correct JSON for the created user' do
        expect(@user.email).to eql @user_attributes[:email]
      end

      it 'generates a confirmation token' do
        expect(@user.confirmation_token).not_to be_nil
      end

      it 'generates an open_id' do
        expect(@user.open_id).not_to be_nil
      end

      it 'generates an authentication_token' do
        expect(@user.authentication_token).not_to be_nil
      end

      it {is_expected.to respond_with 201}
    end

    context 'it does not create an invalid user with blank email' do
      before(:each) do
        @user_attributes[:email] = ''
        post :create, params: { user: @user_attributes} , format: :json
        @user_response = json_response
      end

      it 'renders an error JSON for the invalid request' do
        expect(@user_response[:email]).to eql(["is invalid","can't be blank"])
      end

      it {is_expected.to respond_with 422}
    end

    context 'it does not create an invalid user with existing email' do
      before(:each) do
        @user = FactoryGirl.create(:user)
        @user_attributes[:email] = @user.email
        post :create, params: { user: @user_attributes} , format: :json
        @user_response = json_response
      end

      it 'renders an error JSON for the invalid request' do
        expect(@user_response[:email]).to eql(["has already been taken"])
      end

      it {is_expected.to respond_with 422}
    end

    context 'it does not create an invalid user with empty password' do
      before(:each) do
        @user_attributes[:password] = ''
        post :create, params: { user: @user_attributes} , format: :json
        @user_response = json_response
      end

      it 'renders an error JSON for the invalid request' do
        expect(@user_response[:password]).to include("can't be blank")
      end

      it {is_expected.to respond_with 422}
    end

    context 'it does not create an invalid user with short password' do
      before(:each) do
        @user_attributes[:password] = 'short'
        @user_attributes[:password_confirmation] = 'short'
        post :create, params: { user: @user_attributes} , format: :json
        @user_response = json_response
      end

      it 'renders an error JSON for the invalid request' do
        expect(@user_response[:password]).to include("is too short (minimum is 6 characters)")
      end

      it {is_expected.to respond_with 422}
    end

    context 'it does not create an invalid user with mismatched password' do
      before(:each) do
        @user_attributes[:password_confirmation] = 'something else'
        post :create, params: { user: @user_attributes} , format: :json
        @user_response = json_response
      end

      it 'renders an error JSON for the invalid request' do
        expect(@user_response[:password_confirmation]).to include("doesn't match Password")
      end

      it {is_expected.to respond_with 422}
    end

    context 'it does not create an invalid user with blank first_name or last_name' do
      before(:each) do
        @user_attributes[:first_name] = ''
        @user_attributes[:last_name] = ''
        post :create, params: { user: @user_attributes} , format: :json
        @user_response = json_response
      end

      it 'renders an error JSON for the invalid first name' do
        expect(@user_response[:first_name]).to include("can't be blank")
      end

      it 'renders an error JSON for the invalid last name' do
        expect(@user_response[:last_name]).to include("can't be blank")
      end

      it {is_expected.to respond_with 422}
    end
  end

  # describe 'RegistrationsController#update' do
  #   context 'doorkeeper authorized' do
  #     # let(:token) { double(Doorkeeper::AccessToken, acceptable?: true) }

  #     before(:each) do
  #       @user = FactoryGirl.create(:user)
  #       # allow(controller).to receive(:doorkeeper_token).and_return(token)
  #       # allow(controller).to receive(:current_resource_owner).and_return(@user)
  #       # allow(controller).to receive(:current_user).and_return(@user)
  #     end

  #     context 'it succesfully updates a user password' do
  #       before(:each) do
  #         @new_user_attributes = { password: 'newpassword', password_confirmation:'newpassword', current_password: @user.password }
  #         @old_password = User.find_by(id: @user.id).encrypted_password
  #         put :update, params: { user: @new_user_attributes }, format: :json
  #       # puts "user password is #{@user.password} and DB user password is #{User.find_by(id: @user.id).password}"
  #       # puts "This user's password is #{User.find_by(id: @user.id).encrypted_password}"
  #       end

  #       it 'updates the user password' do
  #         expect(User.find_by(id: @user.id).encrypted_password).not_to eql(@old_password)
  #       end

  #       it { is_expected.to respond_with 204 }
  #     end

  #     context 'it successfully updates a user email' do
  #       before(:each) do
  #         @new_user_attributes = { email: 'abc-new@gmail.com', current_password: @user.password }
  #         put :update, params: { user: @new_user_attributes}, format: :json
  #       end

  #       it 'updates the user email' do
  #         expect(User.find_by(id: @user.id).email).to eql('abc-new@gmail.com')
  #       end

  #       it { is_expected.to respond_with 204 }
  #     end

  #     context 'it successfully updates other info' do
  #       before(:each) do
  #         @new_user_attributes = { first_name: 'Ahnyounh' }
  #         put :update, params: { user: @new_user_attributes}, format: :json
  #       end

  #       it 'updates the user email' do
  #         expect(User.find_by(id: @user.id).first_name).to eql('Ahnyounh')
  #       end

  #       it { is_expected.to respond_with 204 }
  #     end

  #     context 'it does not update email without current_password' do
  #       before(:each) do
  #         @new_user_attributes = { email: 'abc-new@gmail.com' }
  #         put :update, params: { user: @new_user_attributes}, format: :json
  #       end

  #       it 'renders an error JSON for the invalid request' do
  #         user_response = json_response
  #         expect(user_response).to include(:errors)
  #       end

  #       it 'renders the JSON error' do
  #         user_response = json_response
  #         expect(user_response[:errors][:current_password]).to include("can't be blank")
  #       end

  #       it { is_expected.to respond_with 422 }
  #     end

  #     context 'it does not update password without current_password' do
  #       before(:each) do
  #         @new_user_attributes = { password: 'newpassword', password_confirmation:'newpassword' }
  #         put :update, params: { user: @new_user_attributes}, format: :json
  #       end

  #       it 'renders an error JSON for the invalid request' do
  #         user_response = json_response
  #         expect(user_response).to include(:errors)
  #       end

  #       it 'renders the JSON error' do
  #         user_response = json_response
  #         expect(user_response[:errors][:current_password]).to include("can't be blank")
  #       end

  #       it {is_expected.to respond_with 422}
  #     end
  #   end

  # #   context 'it returns 401 when unauthorized' do
  # #     it 'returns 401' do
  # #       @user = create
  # #       @new_user_attributes = { password: 'newpassword', password_confirmation:'newpassword', current_password: @user.password }
  # #       put :update, params: { user: @new_user_attributes }, format: :json
  # #       expect(response.status).to eql(401)
  # #     end
  # #   end
  # end

  # describe "User#destroy" do
  #   # let(:token) { double(Doorkeeper::AccessToken, acceptable?: true) }

  #   before(:each) do
  #     @user = create
  #     # allow(controller).to receive(:doorkeeper_token).and_return(token)
  #     # allow(controller).to receive(:current_resource_owner).and_return(@user)
  #     # allow(controller).to receive(:current_user).and_return(@user)
  #       # puts User.find_by(id: @user.id).email
  #       delete :destroy, format: :json
  #       # puts User.find_by(id: @user.id).email
  #   end

  #   it 'should delete the User from database' do
  #     expect(User.find_by(id: @user.id)).to be_nil
  #   end

  #   it { is_expected.to respond_with 204 }
  # end

  # describe "Method not Allow" do
  #   it "does not allow new method" do
  #     get :new, format: :json
  #     user_response = json_response
  #     expect(response.status).to eql(404)
  #   end

  #   it "does not allow cancel method" do
  #     get :cancel, format: :json
  #     user_response = json_response
  #     expect(response.status).to eql(404)
  #   end

  #   it "does not allow edit method" do
  #     get :edit, format: :json
  #     user_response = json_response
  #     expect(response.status).to eql(404)
  #   end
  # end

end
