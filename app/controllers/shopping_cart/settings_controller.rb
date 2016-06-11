module ShoppingCart
  class SettingsController < ApplicationController
    before_action :authenticate_user!

    def show
      @user = current_user
      @setting = SettingsForm.new(current_user)
    end

    def update
      setting = SettingsForm.new(current_user, params: params).apply_parameters
      redirect_to main_app.root_path and return if setting.save
      redirect_to settings_path
    end

    def update_password
      user = ShoppingCart.user_model.find(current_user.id)
      if user.update_with_password(parameters_password)
        sign_in user, bypass: true
        redirect_to main_app.root_path
      else
        redirect_to settings_path
      end
    end

    private

    def parameters_password
      params.require(:user).permit(:password, :password_confirmation, :current_password)
    end
  end
end

