# frozen_string_literal: true

module Api
  module V1
    class JobsController < ApplicationController
      before_action :authenticate_user!
      def index
        jobs = QueueJob.all
        render_json('Jobs fetched successfully', jobs)
      end

      def create
        job = QueueJob.new(job_params)
        job.run_at = DateTime.parse(job_params[:run_at]) if job_params[:run_at]
        job.save
        render_json('Job created successfully', job)
      end

      private

      def job_params
        params.require(:job).permit(:priority, :status, :run_at, :job_type, movie: {})
      end
    end
  end
end
