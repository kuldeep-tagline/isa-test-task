# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::JobsControllers', type: :request do
  describe 'GET	/api/v1/jobs' do
    let(:request_call) { get '/api/v1/jobs' }
    let(:user) { create(:user) }
    let(:token) { ApiTokens::Create.new(user).call }
    let(:request_headers) { { Authorization: "Bearer #{token}" } }
    let(:queue_jobs) { create_list(:queue_job, 2, :return_date_job) }

    subject(:request) do
      get(api_v1_jobs_path, headers: request_headers)
    end

    before { queue_jobs }
    let(:expected_response) do
      queue_jobs.map do |job|
        {
          id: job.id,
          priority: job.priority,
          status: job.status,
          run_at: job.run_at.as_json,
          job_type: job.job_type,
          movie: job.movie,
          created_at: job.created_at.as_json,
          updated_at: job.updated_at.as_json
        }
      end
    end

    it 'returns success message with user details' do
      request
      json_body = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(json_body['data']).to eq(expected_response.as_json)
    end
  end

  describe 'POST	/api/v1/jobs' do
    let(:request) { post '/api/v1/jobs', params: params }
    let(:user) { create(:user) }
    let(:token) { ApiTokens::Create.new(user).call }
    let(:request_headers) { { Authorization: "Bearer #{token}" } }

    subject(:request) do
      post(api_v1_jobs_path, headers: request_headers, params: params)
    end

    let(:created_job) { QueueJob.last }

    let(:params) do
      {
        job: {
          priority: 'high',
          status: 'waiting',
          run_at: '2020-01-01T00:00:00.000Z',
          job_type: job_type,
          movie: movie
        }
      }
    end

    let(:expected_response) do
      {
        id: created_job.id,
        priority: 'high',
        status: 'waiting',
        run_at: '2020-01-01T00:00:00.000Z',
        job_type: job_type,
        movie: movie,
        created_at: created_job.created_at.as_json,
        updated_at: created_job.updated_at.as_json
      }
    end
    context 'when job type is "return date job"' do
      let(:job_type) { 'return_date_job' }
      let(:movie) { {} }

      it 'returns success message with user details' do
        request
        json_body = JSON.parse(response.body)
        expect(json_body['code']).to eq(201)
        expect(json_body['data']).to eq(expected_response.as_json)
      end
    end

    context 'when job type is "create movie title job"' do
      let(:job_type) { 'create_movie_title_job' }
      let(:movie) do
        {
          title: 'The Dark Knight',
          description: 'The Dark Knight'
        }
      end

      let(:expected_response) do
        {
          id: created_job.id,
          priority: 'high',
          status: 'waiting',
          run_at: '2020-01-01T00:00:00.000Z',
          job_type: job_type,
          movie: movie,
          created_at: created_job.created_at.as_json,
          updated_at: created_job.updated_at.as_json
        }
      end

      it 'returns success message with user details' do
        request
        json_body = JSON.parse(response.body)
        expect(json_body['code']).to eq(201)
        expect(json_body['data']).to eq(expected_response.as_json)
      end
    end

    context 'with invalid params' do
      let(:params) { 'IamInvalid' }
      let(:movie) { {} }

      let(:expected_response) do
        {
          code: 422,
          errors: [],
          message: 'param is missing or the value is empty: job',
          status: 'Missing Parameter(s)'
        }
      end

      it 'returns success message with user details' do
        request
        json_body = JSON.parse(response.body)
        expect(json_body['code']).to eq(422)
        expect(json_body).to eq(expected_response.as_json)
      end
    end
  end
end
