# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ApplicationErrors

  before_action :authenticate_user!

  TOKEN_PATTERN = /^Bearer (?<token>[^ ]+)/

  def render_4041
    render_404
  end

  private

  def authenticate_user!
    return true if current_user

    render_401
  end

  def current_user_from_api_token
    enc_token = encrypted_token
    return if enc_token.blank?

    User.includes(:api_tokens).find_by(api_tokens: { token: enc_token, expired_at: nil })
  end

  def encrypted_token
    authorization_match = request.headers['Authorization'].to_s.match(TOKEN_PATTERN)
    authorization_match[:token] if authorization_match.present?
  end

  def current_user
    return @current_user if defined?(@current_user)

    @current_user = current_user_from_api_token
  end
end
