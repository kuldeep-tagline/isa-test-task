# frozen_string_literal: true

FactoryBot.define do
  factory :api_token do
    token { SecureRandom.base64(24) }
    user
  end
end
