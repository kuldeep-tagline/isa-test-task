# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      # skip_before_action :authenticate_user!

      def sign_in
        @user = User.find_by_email(params[:email])
        if @user&.valid_password?(params[:password])
          render_json('User signed in successfully', @user.as_json.merge(api_token: @user.api_tokens.last.token || ''))
        else
          render_401('Email or password is invalid')
        end
      end

      def sign_up
        @user = User.new(user_params)
        if @user.save
          render_json('User signed up successfully', @user)
        else
          render_422
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
