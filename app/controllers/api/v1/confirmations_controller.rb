class Api::V1::ConfirmationsController < ApplicationController
  include Api::V1::EncryptionToken

  def show
    # TODO: encrypt token when sending
    # TODO: write tests
    @user = authenticate_confirmation_token(params[:confirmation_token])
    if @user && !@user.confirmed_at

      @user.update(confirmed_at: Time.now.utc)
      @user.save
      render json: @user, status: :ok
    else
      render json: { errors: { confirmation_token: ["is invalid or already confirmed"] } }, status: :unprocessable_entity
    end
  end
end
