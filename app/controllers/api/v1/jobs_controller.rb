# frozen_string_literal: true

module Api
  module V1
    class JobsController < ApplicationController
      def index
        jobs = QueueJob.all
        render_json(msg: 'Jobs fetched successfully', data: jobs)
      end

      def create
        job = QueueJob.new(job_params)
        job.run_at = DateTime.parse(job_params[:run_at]) if job_params[:run_at]
        job.save
        render_json(msg: 'Job created successfully', data: job, status: 201)
      end

      private

      def job_params
        params.require(:job).permit(:priority, :status, :run_at, :job_type, movie: {})
      end
    end
  end
end
