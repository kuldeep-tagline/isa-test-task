# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_user!

      def sign_in
        user = User.find_by_email(params[:email])
        if user&.valid_password?(params[:password])
          render_json(msg: 'User signed in successfully', data: user_with_token(user))
        else
          render_401('Email or password is invalid')
        end
      end

      def sign_up
        user = User.new(user_params)
        if user.save
          render_json(msg: 'User signed up successfully', data: user_with_token(user))
        else
          render_422(user.errors.full_messages)
        end
      end

      private

      def user_with_token(user)
        token = if action_name == 'sign_in' && user.api_tokens.empty?
                  ApiTokens::Create.new(user).call
                else
                  user.api_tokens.last&.token
                end
        user.as_json(only: %i[id email]).merge(api_token: user.api_tokens.last&.token)
      end

      def user_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
