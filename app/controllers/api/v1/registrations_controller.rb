class Api::V1::RegistrationsController < ApplicationController

  # POST /users
  def create
    @user = User.new(create_user_params)

    if @user.save
      # TODO: write test for deliver later
      # Implement callbacks
      UserMailer.signup_confirmation(@user).deliver_later
      render json: @user, status: :created
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # def update
  #   if (update_user_params[:password] && update_user_params[:password_confirmation]) || (update_user_params[:email])
  #     if !@user.authenticate(update_user_params[:current_password])
  #       render json: { current_password: ["is invalid"]}, status: :unprocessable_entity
  #     end
  #   end

  #   if @user.update(update_user_params)
  #     render json: @user
  #   else
  #     render json: @user.errors, status: unprocessable_entity
  #   end
  # end

  # DELETE /users/1
  # def destroy
  #   @user.destroy
  # end



  private
    # Use callbacks to share common setup or constraints between actions.

    # Only allow a trusted parameter "white list" through.
    def create_user_params
      params.require(:user).permit(
        :email,
        :password,
        :password_confirmation,
        :first_name,
        :last_name
        )
    end

    def update_user_params
      params.require(:user).permit(
        :id,
        :email,
        :current_password,
        :password,
        :password_confirmation,
        :first_name,
        :last_name
        )
    end

    def set_user
      @user = User.find_by(id: params[:id])
    end
end
