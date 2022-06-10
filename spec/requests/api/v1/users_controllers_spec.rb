# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  describe 'POST /api/v1/users/sign-in' do
    let(:request_call) { post '/api/v1/users/sign-in', params: params }
    let(:user) { create(:user) }
    let(:api_token) { user.api_tokens.last.token }

    before { user }

    context 'with valid params' do
      let(:params) { { email: user.email, password: 'password' } }
      let(:expected_response) do
        {
          id: user.id,
          email: user.email,
          api_token: api_token
        }
      end

      it 'returns success message with user details' do
        request_call
        json_body = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(json_body['data']).to eq(expected_response.as_json)
      end
    end

    context 'with invalid params' do
      let(:params) { { email: 'IamInvalid', password: 'password' } }

      it 'returns error message' do
        request_call
        json_body = JSON.parse(response.body)

        expect(response).to have_http_status(401)
        expect(json_body['data']).to be_empty
        expect(json_body['message'].join).to eq('Email or password is invalid')
        expect(json_body['messageType']).to eq('error')
      end
    end
  end

  describe 'POST /api/v1/users/sign-up' do
    let(:request_call) { post '/api/v1/users/sign-up', params: params }
    let(:created_user) { User.last }

    context 'with valid params' do
      let(:params) do
        {
          user: {
            email: 'user@test.com',
            password: 'password'
          }
        }
      end

      let(:expected_response) do
        {
          id: created_user.id,
          email: 'user@test.com',
          api_token: nil
        }
      end

      it 'returns success message with user details' do
        request_call
        json_body = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(json_body['data']).to eq(expected_response.as_json)
        expect(json_body['messageType']).to eq('success')
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          user: {
            email: 'IamInvalid',
            password: 'password'
          }
        }
      end

      it "won't create user and returns errors" do
        request_call
        json_body = JSON.parse(response.body)

        expect(response).to have_http_status(422)
        expect(json_body['status']).to eq('Unprocessable Entity')
        expect(json_body['data']).to be_empty
        expect(json_body['message']).to eq(['Email is invalid'])
        expect(json_body['messageType']).to eq('error')
      end
    end
  end
end
