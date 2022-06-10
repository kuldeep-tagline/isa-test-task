# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'admin@test.com' }
    password { 'password' }
  end
end
