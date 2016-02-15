class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    # render json: @user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by(authentication_token: params[:authentication_token])
    end
end
